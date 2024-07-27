import 'dart:developer';
import 'dart:io';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_qr_response.dart';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_reload_response.dart';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_response.dart' as wallet;
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_transaction_reponse.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class EwalletRepository {
  final DioManager dioManager;
  EwalletRepository(this.dioManager);

  Future<wallet.Data>? fetchWallet() async {
    log("getting user's wallet", name: "EwalletRepository");
    var response = await dioManager.dio.get("/v1/wallet");
    
    if (response.statusCode == HttpStatus.ok) {
      wallet.WalletResponse jsonResponse = wallet.WalletResponse.fromJson(response.data);

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

  Future<EwalletReloadResponse>? reloadWallet(String reloadAmount) async {
    log("requesting reload for user's wallet", name: "EwalletRepository");
    var response = await dioManager.dio.post("/v1/wallet/reload", data: {"reload_value": reloadAmount});

    if (response.statusCode == HttpStatus.ok) {
      EwalletReloadResponse jsonResponse = EwalletReloadResponse.fromJson(response.data);

      return jsonResponse;
    } else {
      throw Exception('Failed to reload wallet');
    }
  }

  Future<EwalletQrResponse>? generateQr(String? amount) async {
    log("getting qr/barcode for user's wallet", name: "EwalletRepository");
    var response = await dioManager.dio.post("/v1/wallet/qr/generate", data: {"amount": amount});

    if (response.statusCode == HttpStatus.ok) {
      EwalletQrResponse jsonResponse = EwalletQrResponse.fromJson(response.data);

      return jsonResponse;
    } else {
      throw Exception('Failed to load wallet qr');
    }
  }

  Future<EwalletQrResponse>? validateQr(String ewalletQr) async {
    log("validating scanned qr/barcode $ewalletQr", name: "EwalletRepository");
    var response = await dioManager.dio.post("/v1/wallet/qr/validate", data: {"qr_id": ewalletQr});

    if (response.statusCode == HttpStatus.ok) {
      EwalletQrResponse jsonResponse = EwalletQrResponse.fromJson(response.data);

      return jsonResponse;
    } else {
      throw Exception('Failed to load wallet qr');
    }
  }

  // Future<EwalletReloadResponse>? transferFunds(String amount, String receipent) async {
  //   log("requesting reload for user's wallet", name: "EwalletRepository");
  //   var response = await dioManager.dio.post("/v1/wallet/transfer", data: {"reload_value": amount});

  //   if (response.statusCode == HttpStatus.ok) {
  //     EwalletReloadResponse jsonResponse = EwalletReloadResponse.fromJson(response.data);

  //     return jsonResponse;
  //   } else {
  //     throw Exception('Failed to load wallet');
  //   }
  // }
}
