// ignore_for_file: prefer_const_constructors

import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quadrant_app/pages/screens/Product/ProductScreen.dart';
import 'package:quadrant_app/repositories/CartRepository/models/response.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:text_scroll/text_scroll.dart';

class CheckoutCartItem extends StatefulWidget {
  final Items cartItem;
  const CheckoutCartItem({super.key, required this.cartItem});

  @override
  _CheckoutCartItemState createState() => _CheckoutCartItemState();
}

class _CheckoutCartItemState extends State<CheckoutCartItem> {
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
              if (widget.cartItem.product?.id != null){
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ProductScreen(productId: widget.cartItem.product!.id!),
                  ),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(CustomSizes.borderRadiusMd),
              child: Image.network(
                widget.cartItem.product?.images?[0].url ?? 'https://via.placeholder.com/80', // Replace with the actual image URL
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
                  widget.cartItem.product?.name ?? 'NaN',
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
                      "RM ${widget.cartItem.product?.price?.toStringAsFixed(2)}",
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
                              "x ${widget.cartItem.quantity}",
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
