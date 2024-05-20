import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class AddCardComponent extends StatefulWidget {
  const AddCardComponent({super.key, required this.isDark, required this.text, required this.onTap, this.isLoading = false});

  final bool isDark;
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  State<AddCardComponent> createState() => _AddCardComponentState();
}

class _AddCardComponentState extends State<AddCardComponent> {
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
    if (!widget.isLoading) widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          decoration: BoxDecoration(
            color: _isPressed ? widget.isDark ? CustomColors.outlinedButtonColorDark.withAlpha(100) : CustomColors.primaryDark.withAlpha(90) : widget.isDark ? CustomColors.outlinedButtonColorDark : CustomColors.primaryDark.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: widget.isLoading ?
              LoadingAnimationWidget.staggeredDotsWave(
                color: widget.isDark ? Colors.black87 : Colors.white,
                size: 21,
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.add,
                    color: CustomColors.primaryDark,
                  ),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.primaryDark,
                    ),
                  ),
                ],
              ) ,
          ),
        ),
      ),
    );
  }
}