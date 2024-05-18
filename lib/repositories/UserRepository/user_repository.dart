import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user_response.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class UserRepository {
  final DioManager dioManager;

  UserRepository(this.dioManager);
  
  User? _user;

  Future<User?> getUser() async {
    // if (_user != null) return _user;

    var response = await dioManager.dio.get(
      "/v1/user",
    );

    if (response.statusCode == HttpStatus.ok) {
      UserResponse user = UserResponse.fromJson(response.data);
      if(user.message != null){
        _user = User(user.message?.id ?? "", user.message?.name ?? "", user.message?.email ?? "", user.message?.emailVerified ?? "", user.message?.avatar ?? "", user.message?.role ?? "", user.message?.createdAt ?? "");
      }
    } 
    return _user;
  }
}