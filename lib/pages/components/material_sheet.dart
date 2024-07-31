import 'package:flutter/material.dart';
import 'package:sheet/route.dart';

class MaterialSheetRoute<T> extends SheetRoute<T> {
  final List<double> stops_values;
  MaterialSheetRoute({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color super.barrierColor = Colors.black87,
    super.fit,
    super.animationCurve,
    super.barrierDismissible,
    bool enableDrag = true,
    this.stops_values = const [0, 1],
    double initialStop = 1,
    super.duration,
  }) : super(
          builder: (BuildContext context) => Material(
            child: Builder(
              builder: builder,
            ),
            color: backgroundColor,
            clipBehavior: clipBehavior ?? Clip.none,
            shape: shape,
            elevation: elevation ?? 1,
          ),
          initialExtent: initialStop,
          draggable: enableDrag,
          stops: stops_values,
        );
}
