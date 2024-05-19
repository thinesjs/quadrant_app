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

      return jsonResponse.message?.products;
    } else {
      throw Exception('Failed to load billboard images');
    }
  }

  Future<List<Products>?> searchProduct({ required String query }) async {
    log("search product (query:$query)", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products/all/search?arg=$query");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductsResponse jsonResponse = ProductsResponse.fromJson(response.data);

      return jsonResponse.message?.products;
    } else {
      throw Exception('Failed to load billboard images');
    }
  }
}
