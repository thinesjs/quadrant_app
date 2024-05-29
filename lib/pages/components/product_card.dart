import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class ProductCard extends StatelessWidget {
  bool isDark;
  final String name;
  final double price;
  final double rating;
  final String image;
  final VoidCallback onTap;

  ProductCard({
    super.key,
    required this.isDark,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color:
              isDark ? CustomColors.secondaryDark : CustomColors.secondaryLight,
          borderRadius: BorderRadius.circular(CustomSizes.md),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(CustomSizes.md),
                child: (image != "")
                    ? Image.network(image)
                    : Image.asset('assets/placeholders/placeholder-user.jpg')),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RM ${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
