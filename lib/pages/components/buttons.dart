import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class AppOutlinedButton extends StatefulWidget {
  const AppOutlinedButton({super.key, required this.isDark, required this.text, required this.onTap, this.isLoading = false});

  final bool isDark;
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends State<AppOutlinedButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isPressed ? CustomColors.primaryDark : widget.isDark ? CustomColors.outlinedButtonColorDark : CustomColors.outlinedButtonColorLight,
              width: 1,
            ),
            // color: isDark ? Colors.white : Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: widget.isLoading ?
              LoadingAnimationWidget.staggeredDotsWave(
                color: widget.isDark ? Colors.black87 : Colors.white,
                size: 21,
              )
              : Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ) ,
          ),
        ),
      ),
    );
  }
}
class AppOutlinedIconButton extends StatefulWidget {
  const AppOutlinedIconButton({super.key, required this.isDark, required this.icon, required this.onTap, this.isLoading = false});

  final bool isDark;
  final IconData icon;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  State<AppOutlinedIconButton> createState() => _AppOutlinedIconButtonState();
}

class _AppOutlinedIconButtonState extends State<AppOutlinedIconButton> {
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
      padding: const EdgeInsets.only(right: 4),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isPressed ? CustomColors.primaryDark : widget.isDark ? CustomColors.outlinedButtonColorDark : CustomColors.outlinedButtonColorLight,
              width: 1,
            ),
            // color: isDark ? Colors.white : Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: widget.isLoading ?
              LoadingAnimationWidget.staggeredDotsWave(
                color: widget.isDark ? Colors.black87 : Colors.white,
                size: 21,
              )
              : Icon(widget.icon, size: 20, color: widget.isDark ? CustomColors.textColorDark : CustomColors.textColorLight) ,
          ),
        ),
      ),
    );
  }
}

class AppOutlinedToggleButton extends StatefulWidget {
  const AppOutlinedToggleButton({super.key, required this.isDark, required this.text, required this.onTap, required this.selected, this.isLoading = false});

  final bool isDark;
  final String text;
  final VoidCallback onTap;
  final String selected;
  final bool isLoading;

  @override
  State<AppOutlinedToggleButton> createState() => _AppOutlinedToggleButtonState();
}

class _AppOutlinedToggleButtonState extends State<AppOutlinedToggleButton> {
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
      padding: const EdgeInsets.only(right: 4),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isPressed ? CustomColors.primaryDark : widget.isDark ? CustomColors.outlinedButtonColorDark : (widget.text == widget.selected) ? CustomColors.primaryDark :CustomColors.outlinedButtonColorLight,
              width: 1,
            ),
            // color: isDark ? Colors.white : Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: widget.isLoading ?
              LoadingAnimationWidget.staggeredDotsWave(
                color: widget.isDark ? Colors.black87 : Colors.white,
                size: 21,
              )
              : Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ) ,
          ),
        ),
      ),
    );
  }
}

class AppFilledButton extends StatefulWidget {
  const AppFilledButton({super.key, required this.isDark, required this.text, required this.onTap, this.isBlock = false, this.isLoading = false});

  final bool isDark;
  final String text;
  final VoidCallback onTap;
  final bool isBlock;
  final bool isLoading;

  @override
  State<AppFilledButton> createState() => _AppFilledButtonState();
}

class _AppFilledButtonState extends State<AppFilledButton> {
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
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: !widget.isLoading ? _isPressed ? widget.isDark ? Colors.white70 : Colors.black54 : widget.isDark ? Colors.white : Colors.black87 : widget.isDark ? Colors.white70 : Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: widget.isLoading ?
          LoadingAnimationWidget.fallingDot(
            color: widget.isDark ? Colors.black87 : Colors.white,
            size: 30,
          )
            : Text(
          widget.text,
          style: TextStyle(
            color: widget.isDark ? Colors.black87 : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ) ,
        ),
      ),
    );
  }
}