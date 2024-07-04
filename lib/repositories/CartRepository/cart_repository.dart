import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quadrant_app/repositories/CartRepository/models/cartcheckout_response.dart';
import 'package:quadrant_app/repositories/CartRepository/models/response.dart';
import 'package:quadrant_app/repositories/CartRepository/models/productincart_response.dart' as PICR;
import 'package:quadrant_app/repositories/ProductRepository/models/response.dart';
import 'package:quadrant_app/repositories/ProductRepository/models/singleResponse.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class CartRepository {
  final DioManager dioManager;
  CartRepository(this.dioManager);

  Future<UserCartResponse> fetchCart() async {
    log("getting user's cart", name: "CartRepository");
    var response = await dioManager.dio.get("/v1/cart");

    if (response.statusCode == HttpStatus.ok) {
      UserCartResponse jsonResponse = UserCartResponse.fromJson(response.data);

      return jsonResponse;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<PICR.Data?> checkProductInCart(String productId) async {
    log("checking if product in cart: $productId", name: "CartRepository");
    try {
      var response = await dioManager.dio.get("/v1/cart/$productId");
      if (response.statusCode == HttpStatus.ok) {
        PICR.ProductInCart jsonResponse = PICR.ProductInCart.fromJson(response.data);
        return jsonResponse.data;
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == HttpStatus.notFound &&
            e.response!.data["message"] == "product not in cart") {
          return null;
        } else {
          throw Exception('Failed to load cart');
        }
      }
    }
  }

  Future<UserCartResponse> addProductToCart(String productId) async {
    log("adding product to user's cart", name: "CartRepository");
    var response = await dioManager.dio.post("/v1/cart", data: {"productId": productId, "quantity": 1});

    if (response.statusCode == HttpStatus.ok) {
      UserCartResponse jsonResponse = UserCartResponse.fromJson(response.data);

      return jsonResponse;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<UserCartResponse> removeProductToCart(String productId) async {
    log("remove product to user's cart", name: "CartRepository");
    var response = await dioManager.dio.delete("/v1/cart/$productId");

    if (response.statusCode == HttpStatus.ok) {
      UserCartResponse jsonResponse = UserCartResponse.fromJson(response.data);
      return jsonResponse;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<CartCheckoutResponse> requestCheckout(String paymentMethodId) async {
    log("requesting cart checkout with $paymentMethodId", name: "CartRepository");
    var response = await dioManager.dio.post("/v1/cart/checkout");

    if (response.statusCode == HttpStatus.ok) {
      CartCheckoutResponse jsonResponse = CartCheckoutResponse.fromJson(response.data);
      return jsonResponse;
    } else {
      throw Exception('Failed to load checkout');
    }
  }
}
