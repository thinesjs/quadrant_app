import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quadrant_app/blocs/ewallet/qr/ewallet_qr_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/repositories/EwalletRepository/ewallet_repository.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:sheet/sheet.dart';

class EwalletScanner extends StatefulWidget {
  const EwalletScanner({super.key});

  @override
  State<EwalletScanner> createState() => _EwalletScannerState();
}

class _EwalletScannerState extends State<EwalletScanner> {
  late final EwalletRepository _ewalletRepository;
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.normal
  );

  @override
  void initState() {
    super.initState();
    _ewalletRepository = EwalletRepository(DioManager.instance);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => EwalletQrBloc(ewalletRepository: _ewalletRepository),
      child: BlocListener<EwalletQrBloc, EwalletQrState>(
        listener: (context, state) {
          if(state is EwalletQrValidated){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('QR Code Validated'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Material(
          child: SheetMediaQuery(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Q-ExpressPay'),
                  leading: IconButton(
                    icon: const Icon(Iconsax.arrow_down_1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  bottom: TabBar(
                    dividerHeight: 0,
                    indicatorColor: isDark ? Colors.white : Colors.black,
                    unselectedLabelColor:
                        isDark ? Colors.white54 : Colors.black54,
                    labelColor: isDark ? Colors.white : Colors.black,
                    tabs: const [
                      Tab(text: 'Pay'),
                      Tab(text: 'Scan QR'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    // Pay
                    const PayTab(),
                    // Scan QR
                    ScanQrTab(controller: controller),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }
}

class ScanQrTab extends StatefulWidget {
  const ScanQrTab({
    super.key,
    required this.controller,
  });

  final MobileScannerController controller;

  @override
  State<ScanQrTab> createState() => _ScanQrTabState();
}

class _ScanQrTabState extends State<ScanQrTab> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(const Offset(0, -100)),
      width: 200,
      height: 200,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: MobileScanner(
            fit: BoxFit.fitHeight,
            controller: widget.controller,
            scanWindow: scanWindow,
            
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            overlayBuilder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ScannedBarcodeLabel(barcodes: widget.controller.barcodes),
                ),
              );
            },
            onDetect: (captures) async {
              if (isProcessing) return;
              isProcessing = true;

              final barcodes = captures.barcodes;
              if (barcodes.isNotEmpty) {
                final barcode = barcodes.first;
                context
                    .read<EwalletQrBloc>()
                    .add(ValidateWalletQr(ewalletQrId: barcode.displayValue!));

                await Future.delayed(const Duration(seconds: 5));
              }
              isProcessing = false;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            if (!value.isInitialized ||
                !value.isRunning ||
                value.error != null) {
              return const SizedBox();
            }

            return CustomPaint(
              painter: ScannerOverlay(scanWindow: scanWindow),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleFlashlightButton(controller: widget.controller),
                SwitchCameraButton(controller: widget.controller),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PayTab extends StatefulWidget {
  const PayTab({
    super.key,
  });

  @override
  State<PayTab> createState() => _PayTabState();
}

class _PayTabState extends State<PayTab> {
  late final EwalletRepository _ewalletRepository;

  @override
  void initState() {
    super.initState();
    _ewalletRepository = EwalletRepository(DioManager.instance);
    context.read<EwalletQrBloc>().add(const FetchWalletQr());
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<EwalletQrBloc, EwalletQrState>(
          builder: (context, state) {
            if (state is EwalletQrLoading) {
              return const CircularProgressIndicator();
            } else if (state is EwalletQrLoaded &&
                state.walletQr.data != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImageView(
                    data: state.walletQr.data!.id!,
                    size: 230.0,
                    eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CountdownTimer(
                    endTime: DateTime.parse(state.walletQr.data!.expiresAt!)
                        .millisecondsSinceEpoch,
                    widgetBuilder: (_, time) {
                      if (time == null) {
                        return Column(
                          children: [
                            const Text(
                              'QR EXPIRED',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            AppFilledButton(
                                isDark: isDark,
                                text: "Refresh QR",
                                onTap: () {
                                  context
                                      .read<EwalletQrBloc>()
                                      .add(const FetchWalletQr());
                                })
                          ],
                        );
                      }
                      return Text(
                        'EXPIRES IN ${time.sec ?? 0}s',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      );
                    },
                  )
                ],
              );
            } else {
              return const Text("Error loading QR");
            }
          },
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        final int? availableCameras = state.availableCameras;

        if (availableCameras != null && availableCameras < 2) {
          return const SizedBox.shrink();
        }

        final Widget icon;

        switch (state.cameraDirection) {
          case CameraFacing.front:
            icon = const Icon(Icons.camera_front);
          case CameraFacing.back:
            icon = const Icon(Icons.camera_rear);
        }

        return IconButton(
          iconSize: 32.0,
          icon: icon,
          onPressed: () async {
            await controller.switchCamera();
          },
        );
      },
    );
  }
}

class ToggleFlashlightButton extends StatelessWidget {
  const ToggleFlashlightButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        switch (state.torchState) {
          case TorchState.auto:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_auto),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.off:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_off),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.on:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_on),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.unavailable:
            return const Icon(
              Icons.no_flash,
              color: Colors.grey,
            );
        }
      },
    );
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return const Text(
            'Scan something!',
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white),
          );
        }

        return Text(
          scannedBarcodes.first.displayValue ?? 'No display value.',
          overflow: TextOverflow.fade,
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
