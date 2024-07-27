import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quadrant_app/repositories/CartRepository/models/cartcheckout_response.dart';
import 'package:quadrant_app/repositories/CartRepository/models/response.dart';
import 'package:quadrant_app/repositories/CartRepository/models/productincart_response.dart' as PICR;
import 'package:quadrant_app/repositories/ProductRepository/models/response.dart';
import 'package:quadrant_app/repositories/ProductRepository/models/singleResponse.dart';
import 'package:quadrant_app/utils/enums/cart_type.dart';
import 'package:quadrant_app/utils/helpers.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class CartRepository {
  final DioManager dioManager;
  CartRepository(this.dioManager);

  Future<UserCartResponse> fetchCart(CartType cartType) async {
    log("getting user's cart", name: "CartRepository");
    String cartTypeStr = getCartType(cartType);
    var response = await dioManager.dio.get("/v1/cart/$cartTypeStr");

    if (response.statusCode == HttpStatus.ok) {
      UserCartResponse jsonResponse = UserCartResponse.fromJson(response.data);

      return jsonResponse;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<PICR.Data?> checkProductInCart(String productId, CartType cartType) async {
    log("checking if product in cart: $productId", name: "CartRepository");
    String cartTypeStr = getCartType(cartType);
    try {
      var response = await dioManager.dio.get("/v1/cart/$cartTypeStr/$productId");
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

  Future<UserCartResponse> addProductToCart(String productId, CartType cartType) async {
    log("adding product to user's cart", name: "CartRepository");
    String cartTypeStr = getCartType(cartType);
    var response = await dioManager.dio.post("/v1/cart/$cartTypeStr", data: {"productId": productId, "quantity": 1});

    if (response.statusCode == HttpStatus.ok) {
      UserCartResponse jsonResponse = UserCartResponse.fromJson(response.data);

      return jsonResponse;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<UserCartResponse> removeProductToCart(String productId, CartType cartType) async {
    log("remove product to user's cart", name: "CartRepository");
    String cartTypeStr = getCartType(cartType);
    var response = await dioManager.dio.delete("/v1/cart/$cartTypeStr", data: {"productId": productId});

    if (response.statusCode == HttpStatus.ok) {
      UserCartResponse jsonResponse = UserCartResponse.fromJson(response.data);
      return jsonResponse;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<CartCheckoutResponse> requestCheckout(String paymentMethodId, CartType cartType) async {
    log("requesting cart checkout with $paymentMethodId", name: "CartRepository");
    String cartTypeStr = getCartType(cartType);
    var response = await dioManager.dio.post("/v1/cart/$cartTypeStr/checkout");

    if (response.statusCode == HttpStatus.ok) {
      CartCheckoutResponse jsonResponse = CartCheckoutResponse.fromJson(response.data);
      return jsonResponse;
    } else {
      throw Exception('Failed to load checkout');
    }
  }
}
