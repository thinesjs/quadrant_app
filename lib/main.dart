import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/blocs/qentry/bloc/qentry_bloc.dart';
import 'package:quadrant_app/firebase_options.dart';
import 'package:quadrant_app/pages/main_page.dart';
import 'package:quadrant_app/pages/screens/Authentication/Login/LoginScreen.dart';
import 'package:quadrant_app/pages/splash/SplashPage.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
import 'package:quadrant_app/repositories/UserRepository/user_repository.dart';
import 'package:quadrant_app/utils/helpers.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:quadrant_app/themes/styles.dart';
import 'package:quadrant_app/utils/notification_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // local_notification_service.initialize();

  // final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // log(fcmToken.toString(), name: 'FCM Token');

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   // AndroidNotification? android = message.notification?.android;

  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${notification}');

  //   if (notification != null) {
  //     local_notification_service.createNotification(message);
  //   }
  // });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationBloc _authenticationBloc;
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final QentryBloc _qentryBloc;
  late WebSocketChannel channel;
  bool isFloatingActionBarVisible = false;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository(DioManager.instance);
    _userRepository = UserRepository(DioManager.instance);
    _qentryBloc = QentryBloc();
    _authenticationBloc = AuthenticationBloc(
      authenticationRepository: _authenticationRepository,
      userRepository: _userRepository,
    );
    _authenticationBloc.add(AppStarted()); // Trigger AppStarted event

    initializeFirebase();
    initializeWebSocket();
  }

  void initializeFirebase() async {
    local_notification_service.initialize();

    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log(fcmToken.toString(), name: 'FCM Token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      print('Got a message whilst in the foreground!');
      print('Message data: ${notification}');

      if (notification != null) {
        local_notification_service.createNotification(message);
      }
    });
  }

  Timer? _reconnectTimer;
  final int _reconnectDelay = 3;

  void initializeWebSocket() {
    channel = WebSocketChannel.connect(
      // Uri.parse('ws://localhost:8080/qentry-listen'),
      Uri.parse('ws://quadrant-ws.thinesjs.com/qentry-listen'),
    );

    channel.stream.listen((message) async {
      if (isRecognitionNotification(message)) {
        try {
          var data = jsonDecode(message);
          // log(data);
          _qentryBloc.add(WebSocketMessageReceived(data));
        } catch (e) {
          log('Error parsing message: $e');
        }
      }
    },
    onDone: () {
      log('WebSocket connection closed. Attempting to reconnect...');
      _attemptReconnect();
    },
    onError: (error) {
      log('WebSocket error: $error. Attempting to reconnect...');
      _attemptReconnect();
    },);
  }

  void connectWebSocket() {
  channel = WebSocketChannel.connect(
    Uri.parse('ws://quadrant-ws.thinesjs.com/qentry-listen'),
  );
}

  void _attemptReconnect() {
    if (_reconnectTimer == null || !_reconnectTimer!.isActive) {
      _reconnectTimer = Timer(Duration(seconds: _reconnectDelay), () {
        log('Reconnecting to WebSocket...');
        initializeWebSocket();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationRepository.dispose();
    channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (context) => _authenticationBloc,
        child: BlocProvider(
          create: (context) => _qentryBloc,
          child: AppView(isDark: isDark),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  MainPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginScreen.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
      theme: Styles.themeData(widget.isDark, context),
      darkTheme: Styles.themeData(widget.isDark, context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
