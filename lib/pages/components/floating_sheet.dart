import 'package:flutter/material.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';

class FloatingModal extends StatelessWidget {
  const FloatingModal({super.key, required this.child, this.backgroundColor, this.barrierDismissible = true});
  final Widget child;
  final bool barrierDismissible;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    // DisplayFeatureSubScreen allows to display the modal in just
    // one sub-screen of a foldable device.
    return DisplayFeatureSubScreen(
      anchorPoint: Offset.infinite,
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(30),
          child: child,
        ),
      ),
    );
  }
}

class FloatingSheetRoute<T> extends SheetRoute<T> {
  final bool barrierDismissible;
  FloatingSheetRoute({
    required WidgetBuilder builder,
    this.barrierDismissible = true
  }) : super(
          builder: (BuildContext context) {
            return FloatingModal(
              child: Builder(builder: builder),
            );
          },
          // initialExtent: 0.7,
          fit: SheetFit.loose,
          barrierDismissible: barrierDismissible,
          draggable: barrierDismissible
        );
}
