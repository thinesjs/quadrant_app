import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:quadrant_app/repositories/BillboardRepository/models/response.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class BillboardRepository {
  final DioManager dioManager;
  BillboardRepository(this.dioManager);

  Future<List<Message>?> fetchBillboardImages() async {
    log("getting billboards", name: "BillboardRepository");
    var response = await dioManager.dio.get("/v1/billboards");
    
    if (response.statusCode == HttpStatus.ok) {
      BillboardResponse jsonResponse = BillboardResponse.fromJson(response.data);

      return jsonResponse.message;
    } else {
      throw Exception('Failed to load billboard images');
    }
  }
}
