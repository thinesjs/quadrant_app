import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quadrant_app/repositories/OrderRepository/models/order_response.dart';
import 'package:quadrant_app/repositories/OrderRepository/models/orders_response.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class OrderRepository {
  final DioManager dioManager;
  OrderRepository(this.dioManager);

  Future<List<OrdersResponseData>?> fetchOrders() async {
    log("getting user's cart", name: "OrderRepository");
    var response = await dioManager.dio.get("/v1/orders");

    if (response.statusCode == HttpStatus.ok) {
      OrdersResponse jsonResponse = OrdersResponse.fromJson(response.data);

      return jsonResponse.data;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<OrderResponseData?> fetchOrder(String orderId) async {
    log("getting order: $orderId", name: "OrderRepository");
    var response = await dioManager.dio.get("/v1/orders/$orderId");
    
    if (response.statusCode == HttpStatus.ok) {
      OrderResponse jsonResponse = OrderResponse.fromJson(response.data);
      return jsonResponse.data;
    } else {
      throw Exception('Failed to load order data');
    }
  }


}