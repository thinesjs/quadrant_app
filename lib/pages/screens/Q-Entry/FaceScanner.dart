import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/pages/screens/Q-Entry/translator.dart';
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
  late FaceDetector detector;

  List<CameraDescription>? _availableCameras;
  late CameraDescription description = _availableCameras![0];
  CameraController? _controller;
  CameraLensDirection camDirec = CameraLensDirection.back;

  bool isBusy = false;
  late Size size;
  CameraImage? frame;

  bool isFaceRegistered = false;
  List<Face> faces = [];
  String faceStatusMessage = 'Position your face in the frame';

  void _initializeCamera() async {
    _availableCameras = await availableCameras();
    _controller = CameraController(description, ResolutionPreset.high);
    await _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        size = _controller!.value.previewSize!;
      });

      _controller!.startImageStream((image) {
        if (!isBusy) {
          isBusy = true;
          frame = image;
          doFaceDetectionOnFrame();
        }
      });
    });
  }

  Widget buildResult() {
    if (faces == null || !_controller!.value.isInitialized) {
      return const Center(child: Text('Camera is not initialized'));
    }


    CustomPainter painter = FacePainter(faces, _controller!, size);
    return CustomPaint(
      painter: painter,
    );
  }

  doFaceDetectionOnFrame() async {
    InputImage inputImage = getInputImage();
    List<Face> faces_processed = await detector.processImage(inputImage);

    for (Face face in faces_processed) {
      print("Face location ${face.boundingBox}");
    }

    if(faces_processed.isEmpty){
      setState(() {
        isBusy = false;
        faces = faces_processed;
        faceStatusMessage = 'FACE NOT DETECTED';
      });
      return;
    }else{
      setState(() {
        isBusy = false;
        faces = faces_processed;
        faceStatusMessage = 'FACE DETECTED';
      });
    }
  }

  InputImage getInputImage() {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in frame!.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(frame!.width.toDouble(), frame!.height.toDouble());
    final camera = description;
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(frame!.format.raw);

    final int bytesPerRow =
        frame?.planes.isNotEmpty == true ? frame!.planes.first.bytesPerRow : 0;

    final inputImageMetaData = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation!,
      format: inputImageFormat!,
      bytesPerRow: bytesPerRow,
    );

    final inputImage = InputImage.fromBytes(bytes: bytes, metadata: inputImageMetaData);

    return inputImage;
  }

  @override
  void initState() {
    super.initState();
    detector = FaceDetector(options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast));

    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    // User user = context.select<AuthenticationBloc, User>((bloc) => bloc.state.user);
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    if (_controller == null) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.waveDots(
              color: isDark
                  ? CustomColors.primaryLight
                  : CustomColors.textColorLight,
              size: 24),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: displayWidth,
            height: displayHeight,
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            ),
          ),
          Positioned(
              top: 0.0,
              left: 0.0,
              width: size.width,
              height: size.height,
              child: buildResult()),
          Positioned(
            top: 40.0,
            left: 40.0,
            right: 40.0,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: isFaceRegistered
                    ? Colors.lightBlue.withOpacity(0.47)
                    : Colors.red.withOpacity(0.47),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                faceStatusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 5.0,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.withOpacity(0.47),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SCAN YOUR FACE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Powered By Q-Entry',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              // context.push(LocationPage(
                              //   latitude: latitude,
                              //   longitude: longitude,
                              // ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      IconButton(
                          onPressed: _reverseCamera,
                          icon: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                          )),
                      const Spacer(),
                      BlocConsumer<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          // state.maybeWhen(
                          //   orElse: () {},
                          //   error: (message) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text(message),
                          //       ),
                          //     );
                          //   },
                          //   loaded: (responseModel) {
                          //     // context.pushReplacement(
                          //     //     const AttendanceSuccessPage(
                          //     //   status: 'Berhasil Checkin',
                          //     // ));
                          //   },
                          // );
                        },
                        builder: (context, state) {
                          // return state.maybeWhen(
                          //   orElse: () {
                          //     return IconButton(
                          //       onPressed:
                          //           isFaceRegistered ? _takeAbsen : null,
                          //       icon: const Icon(
                          //         Icons.circle,
                          //         size: 70.0,
                          //       ),
                          //       color: isFaceRegistered
                          //           ? AppColors.red
                          //           : AppColors.grey,
                          //     );
                          //   },
                          //   loading: () => const Center(
                          //     child: CircularProgressIndicator(),
                          //   ),
                          // );
                          return Container();
                        },
                      ),
                      const Spacer(),
                      const SizedBox(height: 48.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _reverseCamera() {}
}

class FacePainter extends CustomPainter {
  FacePainter(this.faces, this.controller, this.absoluteImageSize);

  final Size absoluteImageSize;
  final List<Face> faces;
  final CameraController controller;
  final CameraLensDirection camDiretion = CameraLensDirection.back;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / absoluteImageSize.width;
    final scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.indigoAccent;

    for (Face face in faces) {
      Rect boundingBox = face.boundingBox;

      // Adjust bounding box coordinates based on camera direction
      double left = boundingBox.left;
      double top = boundingBox.top;
      double right = boundingBox.right;
      double bottom = boundingBox.bottom;

      if (camDiretion == CameraLensDirection.front) {
        // If using front camera, flip horizontally
        left = absoluteImageSize.width - boundingBox.right;
        right = absoluteImageSize.height - boundingBox.left;
      }

      // Draw rectangle over the detected face
      canvas.drawRect(
        Rect.fromLTRB(
          translateX(face.boundingBox.left, size, absoluteImageSize),
          translateY(face.boundingBox.top, size, absoluteImageSize),
          translateX(face.boundingBox.right, size, absoluteImageSize),
          translateY(face.boundingBox.bottom, size, absoluteImageSize),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
