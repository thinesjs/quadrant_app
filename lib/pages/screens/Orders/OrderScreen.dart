import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const OrderScreen());
  }

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
    );
  }
}