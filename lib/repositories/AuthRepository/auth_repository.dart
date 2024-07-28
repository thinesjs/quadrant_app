// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quadrant_app/models/Authentication/LoginRespose.dart';
import 'package:quadrant_app/repositories/AuthRepository/models/fcm_response.dart';
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
    // await Future<void>.delayed(const Duration(seconds: 1));
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

  Future<bool> checkFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    var response = await dioManager.dio.get(
      "/v1/user/fcm/$fcmToken",
    );

    if (response.statusCode == HttpStatus.ok) {
      final success = FcmResponse.fromJson(response.data).success;
      if (success == true){
        log("fcm token is linked");
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> registerFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    var response = await dioManager.dio.post(
      "/v1/user/fcm/link",
      data: {
        "token": fcmToken
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final success = FcmResponse.fromJson(response.data).success;
      if (success == true){
        log("fcm token registered");
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> unregisterFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    var response = await dioManager.dio.delete(
      "/v1/user/fcm/$fcmToken/unlink",
    );

    if (response.statusCode == HttpStatus.ok) {
      log("fcm token unregistered");
      return true;
    }
    return false;
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

  Future<User?> updateProfile(String username, String email) async {
    User? _user;
    try {
      var response = await dioManager.dio.put(
        "/v1/user/update", data: {
          "name" : username,
          "email" : email
        }
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
          await CacheManager.clearAll();
          _controller.add(AuthenticationStatus.unauthenticated);
        }
      }
    }
  }

  Future<User?> changeProfileAvatar(String imagePath) async {
    User? _user;
    Dio dio = Dio();
    DateTime dateTime = DateTime.now();

    var timestamp = dateTime.millisecondsSinceEpoch;
    var public_id = "image$timestamp";
    var api_key = "647698169117413";

    var responseSigned;
    var cldResponse;

    try {
      responseSigned = await dioManager.dio.post(
        "/v1/products/image/sign",data: {
          "paramsToSign": {
            "timestamp": timestamp,
            "upload_preset": "jaasktnb",
          }
        }
      );
    } catch (error) {
      if (error is DioException) {
          if (error.response?.statusCode == HttpStatus.badRequest) {

          }
      }
    }

    try {
        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(imagePath),
          "signature": responseSigned.data["signature"],
          "api_key": api_key,
          "timestamp": timestamp,
          "upload_preset": "jaasktnb",
        });

        cldResponse = await dio.post("https://api.cloudinary.com/v1_1/dz6ucd5lw/image/upload",
          data: formData
        );
    } catch (error) {
      if (error is DioException) {
          if (error.response?.statusCode == HttpStatus.badRequest) {

          }
      }
    }

    try {
      var response = await dioManager.dio.put(
        "/v1/user/avatar/update", data: {
          "avatarUrl" : cldResponse.data['secure_url']
        }
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
    await unregisterFcmToken();
    await CacheManager.clearAll();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}