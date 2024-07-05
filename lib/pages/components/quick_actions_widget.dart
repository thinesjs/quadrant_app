import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({
    super.key, required this.text, required this.icon, required this.onTap,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.24,
        decoration: BoxDecoration(
          color:
              isDark ? CustomColors.cardColorDark : CustomColors.cardColorLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                child: Icon(
                  icon,
                  color: isDark
                      ? CustomColors.textColorDark
                      : CustomColors.textColorLight,
                  size: 36,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
