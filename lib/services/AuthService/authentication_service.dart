import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:quadrant_app/services/AuthService/models/LoginBody.dart';
import 'package:quadrant_app/services/Initialization/network/dio_manager.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

enum NetworkEnums {
  login('login'),
  introOff('introOff'),
  token('token');

  final String path;
  const NetworkEnums(this.path);
}

class AuthenticationService {
  final DioManager dioManager;

  AuthenticationService(this.dioManager);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login({
    required String email,
    required String password,
    required String device_name
  }) async {
    var response = await dioManager.dio.post(
      "/api/login",
      data: LoginBody(
        email: email,
        password: password,
        device_name: device_name,
      ).toJson(),
    );

    log(response.toString());

    if (response.statusCode == HttpStatus.ok) {
      _controller.add(AuthenticationStatus.authenticated);
    } 
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}