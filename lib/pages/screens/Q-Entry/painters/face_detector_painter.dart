import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:lottie/lottie.dart';

import 'coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
    this.faces,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.red;
    final Paint paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..color = Colors.green;

    for (final Face face in faces) {
      final left = translateX(
        face.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        face.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        face.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        face.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      // canvas.drawRect(
      //   Rect.fromLTRB(left, top, right, bottom),
      //   paint1,
      // );

      // void paintLandmark(FaceLandmarkType type) {
      //   final landmark = face.landmarks[type];
      //   if (landmark?.position != null) {
      //     canvas.drawCircle(
      //         Offset(
      //           translateX(
      //             landmark!.position.x.toDouble(),
      //             size,
      //             imageSize,
      //             rotation,
      //             cameraLensDirection,
      //           ),
      //           translateY(
      //             landmark.position.y.toDouble(),
      //             size,
      //             imageSize,
      //             rotation,
      //             cameraLensDirection,
      //           ),
      //         ),
      //         2,
      //         paint2);
      //   }
      // }

      // for (final type in FaceLandmarkType.values) {
      //   paintLandmark(type);
      // }

      void paintContour(FaceContourType type) {
        final contour = face.contours[type];
        if (contour?.points != null) {
          for (final Point point in contour!.points) {
            canvas.drawCircle(
                Offset(
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
                ),
                1,
                paint1);
          }
        }
      }

      // for (final type in FaceContourType.values) {
      //   paintContour(type);
      // }
      // paintContour(FaceContourType.leftEye);
      // paintContour(FaceContourType.rightEye);
      paintContour(FaceContourType.noseBridge);
      paintContour(FaceContourType.noseBottom);

      void paintContour1(FaceContourType type) {
        final contour = face.contours[type];
        if (contour?.points != null && contour!.points.length > 1) {
          for (int i = 0; i < contour.points.length - 1; i++) {
            final Point point1 = contour.points[i];
            final Point point2 = contour.points[i + 1];
            canvas.drawLine(
              Offset(
                translateX(
                  point1.x.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  point1.y.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
              ),
              Offset(
                translateX(
                  point2.x.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  point2.y.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
              ),
              paint1,
            );
          }
          // Optionally, connect the last point to the first point to close the contour
          final Point firstPoint = contour.points.first;
          final Point lastPoint = contour.points.last;
          canvas.drawLine(
            Offset(
              translateX(
                lastPoint.x.toDouble(),
                size,
                imageSize,
                rotation,
                cameraLensDirection,
              ),
              translateY(
                lastPoint.y.toDouble(),
                size,
                imageSize,
                rotation,
                cameraLensDirection,
              ),
            ),
            Offset(
              translateX(
                firstPoint.x.toDouble(),
                size,
                imageSize,
                rotation,
                cameraLensDirection,
              ),
              translateY(
                firstPoint.y.toDouble(),
                size,
                imageSize,
                rotation,
                cameraLensDirection,
              ),
            ),
            paint1,
          );
        }
      }

      // Call the method for each contour type
      // for (final type in FaceContourType.values) {}
      // paintContour1(FaceContourType.face);
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }
}
