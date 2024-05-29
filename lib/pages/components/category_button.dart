import 'package:flutter/material.dart';
import 'package:quadrant_app/pages/screens/Category/CategoryScreen.dart';
import 'package:quadrant_app/pages/screens/Home/HomeScreen.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({
    super.key,
    required this.category,
    required this.isDark, 
    required this.onTap,
  });

  final Category category;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
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
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Column(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: widget.isDark ? CustomColors.secondaryDark : CustomColors.secondaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.category.icon,
              color: widget.isDark ? _isPressed ? CustomColors.primaryLight : CustomColors.primaryDark : _isPressed ? CustomColors.primaryDark : CustomColors.primaryLight,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.category.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
