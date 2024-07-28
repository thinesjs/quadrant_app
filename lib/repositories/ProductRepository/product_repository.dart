import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quadrant_app/blocs/product/bloc/product_bloc.dart';
import 'package:quadrant_app/repositories/CartRepository/models/productincart_response.dart' as picr;
import 'package:quadrant_app/repositories/ProductRepository/models/response.dart';
import 'package:quadrant_app/repositories/ProductRepository/models/singleResponse.dart';
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

  Future<Product?> fetchProduct(String productId) async {
    log("getting product: $productId", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products/$productId");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductResponse jsonResponse = ProductResponse.fromJson(response.data);
      return jsonResponse.message?.product;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product?> fetchProductByUPC(String upcCode) async {
    log("getting product by upc: $upcCode", name: "ProductRepository");
    var response = await dioManager.dio.get("/v1/products/upc/$upcCode");
    
    if (response.statusCode == HttpStatus.ok) {
      ProductResponse jsonResponse = ProductResponse.fromJson(response.data);
      return jsonResponse.message?.product;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<picr.Data?> checkProductInCart(String productId) async {
    log("getting product: $productId", name: "ProductRepository");
    try {
      var response = await dioManager.dio.get("/v1/cart/$productId");
      if (response.statusCode == HttpStatus.ok) {
        picr.ProductInCart jsonResponse = picr.ProductInCart.fromJson(response.data);
        return jsonResponse.data;
      } else {
        throw Exception('Failed to load products');
      }
      
    } catch (e) {
      if(e is DioException){
        if(e.response!.statusCode == HttpStatus.notFound && e.response!.data["message"] == "product not in cart"){
          return null;
        }else{
          throw Exception('Failed to load products');
        }
      }
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

  // addProductToCart
}
