import 'package:flutter/material.dart';
import 'package:quadrant_app/pages/screens/Category/CategoryScreen.dart';
import 'package:quadrant_app/pages/screens/Home/HomeScreen.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class ItemGridButton extends StatefulWidget {
  const ItemGridButton({
    super.key,
    required this.context,
    required this.items,
    required this.isDark, 
    required this.onTap,
  });

  final BuildContext context;
  final Item items;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<ItemGridButton> createState() => _ItemGridButtonState();
}

class _ItemGridButtonState extends State<ItemGridButton> {
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
              widget.items.icon,
              color: widget.isDark ? _isPressed ? CustomColors.primaryLight : CustomColors.primaryDark : _isPressed ? CustomColors.primaryDark : CustomColors.primaryLight,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.items.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
