import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class ProductCard extends StatelessWidget {
  final bool isDark;
  final String name;
  final double price;
  final double rating;
  final String image;

  const ProductCard({super.key, 
    required this.isDark,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isDark ? CustomColors.secondaryDark : CustomColors.secondaryLight,
        borderRadius: BorderRadius.circular(CustomSize.md),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(CustomSize.md),
            child: (image != "") ? Image.network(image) : Image.asset('assets/placeholders/placeholder-user.jpg')
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RM ${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '0.0',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}

