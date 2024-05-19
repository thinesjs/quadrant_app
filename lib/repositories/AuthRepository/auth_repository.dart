// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quadrant_app/models/Authentication/LoginRespose.dart';
import 'package:quadrant_app/repositories/AuthRepository/models/login_payload.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user_response.dart';
import 'package:quadrant_app/utils/helpers/cache/cache_manager.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

enum NetworkEnums {
  login('login'),
  introOff('introOff'),
  token('token');

  final String path;
  const NetworkEnums(this.path);
}

class AuthenticationRepository {
  final DioManager dioManager;

  AuthenticationRepository(this.dioManager);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  Future<String?> login({
    required String email,
    required String password,
    required String device_name
  }) async {
    
    var response = await dioManager.dio.post(
      "/v1/auth/login",
      data: LoginBody(
        email: email,
        password: password,
      ).toJson(),
    );

    if (response.statusCode == HttpStatus.ok) {
      final access_token = LoginResponse.fromJson(response.data).message?.accessToken;

      if (access_token != null){
        return access_token;
      }
    }
  }

  Future<User?> removeProfileAvatar() async {
    User? _user;

    try {
      var response = await dioManager.dio.delete(
        "/v1/user/avatar/remove",
      );

      if (response.statusCode == HttpStatus.ok) {
        UserResponse user = UserResponse.fromJson(response.data);

        if (user.message != null) {
            _user = User(
                user.message?.id ?? "",
                user.message?.name ?? "",
                user.message?.email ?? "",
                user.message?.emailVerified ?? "",
                user.message?.avatar ?? "",
                user.message?.role ?? "",
                user.message?.createdAt ?? "");

        }
      }
      return _user;
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == HttpStatus.badRequest) {
          // implement refresh token
          await CacheManager.clearAll();
          _controller.add(AuthenticationStatus.unauthenticated);
        }
      }
    }
    
  }

  Future<void> updateToken(String? token) async {
    if(token != null){
      await CacheManager.setString("access_token", token);
      DioManager.instance.dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      _controller.add(AuthenticationStatus.authenticated);
    }else{
      if(await CacheManager.containsKey("access_token")){
        await CacheManager.remove("access_token");
        DioManager.instance.dio.options.headers.clear();
      }
    }
  }

  Future<void> updateTokenFromStorage() async {
    if(await CacheManager.containsKey("access_token")){
      final token = await CacheManager.getString("access_token");
      if(token != null){
        DioManager.instance.dio.options.headers = {
          'Authorization': 'Bearer $token',
        };
      }else{
        DioManager.instance.dio.options.headers.clear();
      }
    }
  }

  Future<bool> isLoggedIn() async {
    return (await CacheManager.getBool("/api/login")) ?? false;
  }

  Future<void> updateLoggedIn(bool isLoggedIn) async {
    await CacheManager.setBool("/api/login", isLoggedIn);
  }

  Future<void> logOut() async {
    await CacheManager.clearAll();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}