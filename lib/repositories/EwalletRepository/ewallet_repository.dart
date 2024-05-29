import 'dart:developer';
import 'dart:io';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_response.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class EwalletRepository {
  final DioManager dioManager;
  EwalletRepository(this.dioManager);

  Future<Data>? fetchWallet() async {
    log("getting user's wallet", name: "EwalletRepository");
    var response = await dioManager.dio.get("/v1/wallet");
    
    if (response.statusCode == HttpStatus.ok) {
      WalletResponse jsonResponse = WalletResponse.fromJson(response.data);

      return jsonResponse.data!;
    } else {
      throw Exception('Failed to load wallet');
    }
  }

  // Future<Product?> fetchProduct(String productId) async {
  //   log("getting product: $productId", name: "ProductRepository");
  //   var response = await dioManager.dio.get("/v1/products/$productId");
    
  //   if (response.statusCode == HttpStatus.ok) {
  //     ProductResponse jsonResponse = ProductResponse.fromJson(response.data);
  //     return jsonResponse.message?.product;
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

 
}
