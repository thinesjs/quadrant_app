// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/repositories/OrderRepository/models/orders_response.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class OrderCardComponent extends StatefulWidget {
  const OrderCardComponent({
    super.key,
    required this.isDark,
    required this.orderNum,
    required this.order,
    required this.onTap,
  });

  final bool isDark;
  final int orderNum;
  final OrdersResponseData order;
  final VoidCallback onTap;

  @override
  State<OrderCardComponent> createState() => _OrderCardComponentState();
}

class _OrderCardComponentState extends State<OrderCardComponent> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    // if (!widget.isLoading) widget.onTap();
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          height: 210,
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // color: widget.isDark
            //     ? CustomColors.cardColorDark
            //     : CustomColors.cardColorLight,
            border: Border.all(
              color: widget.isDark
                  ? CustomColors.outlinedButtonColorDark
                  : CustomColors.outlinedButtonColorLight,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Order: #${widget.orderNum}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.order.isPaid == false)
                        Text(
                          " (Unpaid)",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    "(${widget.order.orderItems?.length.toString()} items) RM ${widget.order.total?.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: CustomPaint(
                      painter: DashedLinePainter(),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(CustomSizes.borderRadiusMd),
                    child: Image.network(
                      widget.order.orderItems?.first.product?.images?.first
                              .url ??
                          'https://via.placeholder.com/80', // Replace with the actual image URL
                      width: 80,
                      height: 80,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.order.orderItems?.first.product?.name ?? "N/A",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "RM ${widget.order.orderItems?.first.product?.price?.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Qty: ${widget.order.orderItems?.first.quantity}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.order.orderItems!.length > 1)
                Column(
                  children: [
                    SizedBox(height: 8),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Iconsax.arrow_right,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
