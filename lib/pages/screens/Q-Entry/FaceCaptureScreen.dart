import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:lottie/lottie.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/painters/coordinates_translator.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/painters/face_detector_painter.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/utils/camera_view.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FacialCaptureScreen extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => FacialCaptureScreen());
  }

  @override
  _FacialCaptureScreenState createState() => _FacialCaptureScreenState();
}

class _FacialCaptureScreenState extends State<FacialCaptureScreen> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String _text = "Position your face within the frame";
  var _cameraLensDirection = CameraLensDirection.front;
  List<Face> _faces = [];
  InputImageRotation _rotation = InputImageRotation.rotation90deg;
  Size _size = Size(0, 0);
  int _captureCount = 0;
  final List<String> _captureInstructions = [
    "Position your face within the frame",
    "Move your face slightly to the left",
    "Move your face slightly to the right"
  ];

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final faces = await _faceDetector.processImage(inputImage);
    if(faces.isNotEmpty){
      setState(() {
         _text = _captureInstructions[_captureCount];
      });
    }else{
      setState(() {
        _text = 'Position your face within the frame';
      });
    }
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
          setState(() {
            _size = inputImage.metadata!.size;
            _faces = faces;
          });
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);

      // log(inputImage.metadata!.size.toString());
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Facial Data'),
      ),
      body: Center(
        child: Stack(
          children: [
            CameraView(
              faces: _faces,
              customPaint: _customPaint,
              onImage: _processImage,
              initialCameraLensDirection: _cameraLensDirection,
              onCameraLensDirectionChanged: (value) =>
                  _cameraLensDirection = value,
            ),
            // Overlay for face detection box
            // ..._faces
            //     .map((face) => LottieOverlay(
            //         face: face,
            //         imageSize: _size,
            //         screenSize: const Size(1280, 720),
            //         rotation: _rotation,
            //         cameraLensDirection: _cameraLensDirection))
            //     .toList(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FacialCaptureScreen(),
  ));
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
        'assets/animations/face-id.json', 
        fit: BoxFit.fill,
      ),
    );
  
  }
}