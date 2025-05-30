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
          borderRadius: BorderRadius.circular(CustomSizes.md),
          child: Image(
            fit: BoxFit.contain,
            image: (imageUrl != "") ? NetworkImage(imageUrl) : const AssetImage('assets/placeholders/placeholder-banner.png') as ImageProvider<Object>
          ),
        ),
      ),
    );
  }
}