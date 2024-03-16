import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key, required this.hint, required this.txtController, required this.onChange, this.isLoading = false,
  }) : super(key: key);

  final String hint;
  final Function(String val) onChange;
  bool isLoading;
  final TextEditingController txtController;  

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: BackdropFilter(
          filter: isDark ? ImageFilter.blur(sigmaX: 10, sigmaY: 10) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(.2) : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
                  controller: txtController,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: onChange,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        Iconsax.search_normal,
                        color: isDark ? const Color(0xFFFEFDFE) : Colors.black87
                        ),
                    ),
                    suffixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: !isLoading ? Icon(Iconsax.filter, color: isDark ? const Color(0xFFFEFDFE) : Colors.black87) : LoadingAnimationWidget.inkDrop(
                        color: isDark ? const Color(0xFFFEFDFE) : Colors.black87,
                        size: 24,
                      )
                    ),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
        
                ),
          ),
        ),
      ),
    );
  }
}