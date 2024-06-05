import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:lottie/lottie.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/painters/coordinates_translator.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/painters/face_detector_painter.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/utils/camera_view.dart';

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
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;
  List<Face> _faces = [];
  InputImageRotation _rotation = InputImageRotation.rotation90deg;
  Size _size = Size(0, 0);

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
          setState(() {
            _size = inputImage.metadata!.size;
          });
          log(inputImage.metadata!.size.toString());
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Facial Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: const Text(
                'Position your face within the frame',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: Stack(
                children: [
                  // Placeholder for camera feed
                  CameraView(
                    customPaint: _customPaint,
                    onImage: _processImage,
                    initialCameraLensDirection: _cameraLensDirection,
                    onCameraLensDirectionChanged: (value) =>
                        _cameraLensDirection = value,
                  ),
                  // Overlay for face detection box
                  ..._faces.map((face) => LottieOverlay(face: face, imageSize: _size, screenSize: const Size(300, 300), rotation: _rotation, cameraLensDirection: _cameraLensDirection)).toList(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Logic to capture facial data
                },
                child: const Text('Capture'),
              ),
            ),
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
        'assets/animations/face-id.json', // Your Lottie animation file
        fit: BoxFit.fill,
      ),
    );
  
  }
}