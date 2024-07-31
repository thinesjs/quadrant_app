// ignore_for_file: prefer_const_constructors

import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quadrant_app/pages/screens/Product/ProductScreen.dart';
import 'package:quadrant_app/repositories/CartRepository/models/response.dart';
import 'package:quadrant_app/repositories/OrderRepository/models/order_response.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:text_scroll/text_scroll.dart';

class OrderItemComponent extends StatefulWidget {
  final OrderItems orderItem;
  const OrderItemComponent({super.key, required this.orderItem});

  @override
  _OrderItemComponentState createState() => _OrderItemComponentState();
}

class _OrderItemComponentState extends State<OrderItemComponent> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomSizes.borderRadiusMd),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.orderItem.product?.id != null){
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ProductScreen(productId: widget.orderItem.product!.id!),
                  ),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(CustomSizes.borderRadiusMd),
              child: Image.network(
                widget.orderItem.product?.images?[0].url ?? 'https://via.placeholder.com/80', // Replace with the actual image URL
                width: 80,
                height: 80,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextScroll(
                  widget.orderItem.product?.name ?? 'NaN',
                  pauseBetween: const Duration(milliseconds: 3000),
                  delayBefore: const Duration(milliseconds: 1500),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "RM ${widget.orderItem.product?.price?.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? CustomColors.backgroundDark : CustomColors.cardColorLight,
                        borderRadius: BorderRadius.circular(CustomSizes.borderRadiusLg),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "x ${widget.orderItem.quantity}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
    
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
