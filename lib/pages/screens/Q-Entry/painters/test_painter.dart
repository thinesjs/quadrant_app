import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'coordinates_translator.dart';

class FacePositionPainter extends CustomPainter {
  FacePositionPainter({
    required this.faces,
    required this.imageSize,
    required this.rotation,
    required this.cameraLensDirection,
    required this.onFaceContoursDetected,
  });

  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;
  final Function(Map<String, Offset>) onFaceContoursDetected;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.red;
    final Paint paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..color = Colors.green;

    for (final Face face in faces) {
      Map<String, Offset> facePositions = {};

      void paintContour(FaceContourType type) {
        final contour = face.contours[type];
        if (contour?.points != null) {
          for (final Point point in contour!.points) {
            final translatedPoint = Offset(
              translateX(
                point.x.toDouble(),
                size,
                imageSize,
                rotation,
                cameraLensDirection,
              ),
              translateY(
                point.y.toDouble(),
                size,
                imageSize,
                rotation,
                cameraLensDirection,
              ),
            );

            canvas.drawCircle(translatedPoint, 1, paint1);

            if (type == FaceContourType.lowerLipTop) {
              facePositions['mouth'] = translatedPoint;
            } else if (type == FaceContourType.leftEye) {
              facePositions['leftEye'] = translatedPoint;
            } else if (type == FaceContourType.rightEye) {
              facePositions['rightEye'] = translatedPoint;
            }
          }
        }
      }

      for (final type in FaceContourType.values) {
        paintContour(type);
      }

      onFaceContoursDetected(facePositions);
    }
  }

  @override
  bool shouldRepaint(FacePositionPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }
}
