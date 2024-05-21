import 'dart:developer';
import 'dart:io';
import 'package:quadrant_app/repositories/ProfileRepository/models/response.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class ProfileRepository {
  final DioManager dioManager;
  ProfileRepository(this.dioManager);

  Future<List<Message>?> fetchProfiles() async {
    log("getting profile", name: "ProfileRepository");
    var response = await dioManager.dio.get("/v1/profiles");
    
    if (response.statusCode == HttpStatus.ok) {
      ProfileResponse jsonResponse = ProfileResponse.fromJson(response.data);

      return jsonResponse.message!;
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<bool> setDefaultProfile(String profileId) async {
    log("set default profile", name: "ProfileRepository");
    var response = await dioManager.dio.put("/v1/profiles/$profileId/setDefault");
    
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
