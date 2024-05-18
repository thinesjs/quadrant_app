import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:quadrant_app/repositories/ProductRepository/models/response.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class ProductRepository {
  final DioManager dioManager;
  ProductRepository(this.dioManager);

  Future<List<Products>?> fetchProducts() async {
    log("getting products", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductsResponse jsonResponse = ProductsResponse.fromJson(response.data);

      await Future.delayed(const Duration(seconds: 2));

      return jsonResponse.message?.products;
    } else {
      throw Exception('Failed to load billboard images');
    }
  }
}
