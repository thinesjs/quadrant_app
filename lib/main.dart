import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/pages/main_page.dart';
import 'package:quadrant_app/pages/screens/Authentication/Login/LoginScreen.dart';
import 'package:quadrant_app/pages/screens/Home/HomeScreen.dart';
import 'package:quadrant_app/pages/screens/Onboarding/OnboardScreen.dart';
import 'package:quadrant_app/pages/splash/SplashPage.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';
import 'package:quadrant_app/repositories/UserRepository/user_repository.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:quadrant_app/themes/styles.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
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


  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository(DioManager.instance);
    _userRepository = UserRepository(DioManager.instance);

    _authenticationBloc = AuthenticationBloc(
      authenticationRepository: _authenticationRepository,
      userRepository: _userRepository,
    );
    _authenticationBloc.add(AppStarted()); // Trigger AppStarted event
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (context) => _authenticationBloc,
        child: AppView(isDark: isDark),
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