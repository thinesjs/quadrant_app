import 'dart:developer';
import 'dart:io';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_response.dart';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallettransaction_reponse.dart';
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

  Future<WalletTransactionsData>? fetchWalletTransactions() async {
    log("getting user's wallet transactions", name: "EwalletRepository");
    var response = await dioManager.dio.get("/v1/wallet/transactions");
    
    if (response.statusCode == HttpStatus.ok) {
      WalletTransactionsResponse jsonResponse = WalletTransactionsResponse.fromJson(response.data);

      return jsonResponse.data!;
    } else {
      throw Exception('Failed to load wallet transactions');
    }
  }
}
