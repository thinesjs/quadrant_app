// ignore_for_file: prefer_const_constructors

import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:flutter/material.dart';
import 'package:quadrant_app/pages/screens/Product/ProductScreen.dart';
import 'package:quadrant_app/repositories/CartRepository/models/response.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class ShoppingCartItem extends StatefulWidget {
  final Items cartItem;
  const ShoppingCartItem({super.key, required this.cartItem});

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? CustomColors.navBorderDark : CustomColors.navBorderLight,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(CustomSizes.borderRadiusMd),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.cartItem.product?.id != null){
                Navigator.push(
                  context,
                  MaterialPageRoute(
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
                Text(
                  widget.cartItem.product?.name ?? 'NaN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                // Text(
                //   'Size: 6.5',
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.grey,
                //   ),
                // ),
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
                          IconButton(
                            onPressed: _decrementQuantity,
                            icon: Icon(Icons.remove),
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          Text(
                            widget.cartItem.quantity.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: _incrementQuantity,
                            icon: Icon(Icons.add),
                            color: isDark ? Colors.white : Colors.black,
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
