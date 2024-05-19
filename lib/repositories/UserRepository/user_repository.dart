import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user_response.dart';
import 'package:quadrant_app/utils/helpers/cache/cache_manager.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class UserRepository {
  final DioManager dioManager;

  UserRepository(this.dioManager);

  final _controller = StreamController<AuthenticationStatus>();
  User? _user;

  Future<User?> getUser() async {
    // if (_user != null) return _user;

    try {
      log("getting profile", name: "UserRepository");
      var response = await dioManager.dio.get(
        "/v1/user",
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
}
