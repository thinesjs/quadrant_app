import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class PromoImageComponent extends StatelessWidget {
  const PromoImageComponent({
    super.key,
    required this.imageUrl,
    required this.margin,
    required this.onTap,
  });

  final String imageUrl;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(CustomSize.md),
          child: Image(
            fit: BoxFit.contain,
            image: NetworkImage(imageUrl)
          ),
        ),
      ),
    );
  }
}