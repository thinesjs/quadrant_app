import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/painters/coordinates_translator.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/painters/face_detector_painter.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/utils/camera_view.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/face_recognition/embedding.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;

class FaceScanner extends StatefulWidget {
  const FaceScanner({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const FaceScanner());
  }

  @override
  State<FaceScanner> createState() => _FaceScannerState();
}

class _FaceScannerState extends State<FaceScanner> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;
  List<Face> _faces = [];
  InputImageRotation _rotation = InputImageRotation.rotation90deg;

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    // setState(() {
    //   _faces = [];
    // });
    final faces = await _faceDetector.processImage(inputImage);
    setState(() {
      _faces = faces;
    });
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // User user = context.select<AuthenticationBloc, User>((bloc) => bloc.state.user);
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    
    return Stack(
      children: [
        CameraView(
          customPaint: _customPaint,
          onImage: _processImage,
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
        ),
        ..._faces.map((face) => LottieOverlay(face: face, imageSize: Size(1280, 720), screenSize: MediaQuery.of(context).size, rotation: _rotation, cameraLensDirection: _cameraLensDirection)).toList(),

      ],
    );
  }
}

class LottieOverlay extends StatelessWidget {
  final Face face;
  final Size imageSize;
  final Size screenSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;


  const LottieOverlay({
    Key? key,
    required this.face,
    required this.imageSize,
    required this.screenSize, required this.rotation, required this.cameraLensDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final left = translateX(
      face.boundingBox.left,
      screenSize,
      imageSize,
      rotation,
      cameraLensDirection,
    );
    final top = translateY(
      face.boundingBox.top,
      screenSize,
      imageSize,
      rotation,
      cameraLensDirection,
    );
    final right = translateX(
      face.boundingBox.right,
      screenSize,
      imageSize,
      rotation,
      cameraLensDirection,
    );
    final bottom = translateY(
      face.boundingBox.bottom,
      screenSize,
      imageSize,
      rotation,
      cameraLensDirection,
    );

    return Positioned(
      left: left,
      top: top,
      width: right - left,
      height: (bottom - top),
      child: Lottie.asset(
        'assets/animations/face-id.json', // Your Lottie animation file
        fit: BoxFit.fill,
      ),
    );
  
  }
}