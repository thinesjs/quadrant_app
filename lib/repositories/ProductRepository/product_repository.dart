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
      throw Exception('Failed to load products');
    }
  }

  Future<List<Products>?> fetchProductsByCategory(String category) async {
    log("getting products by category", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products?category=$category");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductsResponse jsonResponse = ProductsResponse.fromJson(response.data);

      return jsonResponse.message?.products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Products>?> fetchFeaturedProducts() async {
    log("getting featured products", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products/featured");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductsResponse jsonResponse = ProductsResponse.fromJson(response.data);

      return jsonResponse.message?.products;
    } else {
      throw Exception('Failed to load featured products');
    }
  }

  Future<List<Products>?> fetchForYouProducts() async {
    log("getting for you products", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products/for-you");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductsResponse jsonResponse = ProductsResponse.fromJson(response.data);

      return jsonResponse.message?.products;
    } else {
      throw Exception('Failed to load featured products');
    }
  }

  Future<List<Products>?> fetchNewArrivalProducts() async {
    log("getting new arrival products", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products/new-arrivals");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductsResponse jsonResponse = ProductsResponse.fromJson(response.data);

      return jsonResponse.message?.products;
    } else {
      throw Exception('Failed to load featured products');
    }
  }

  Future<List<Products>?> searchProduct({ required String query }) async {
    log("search product (query:$query)", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products/all/search?arg=$query");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductsResponse jsonResponse = ProductsResponse.fromJson(response.data);

      return jsonResponse.message?.products;
    } else {
      throw Exception('Failed to search product');
    }
  }
}
