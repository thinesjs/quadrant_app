import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sheet/sheet.dart';

class ExpressCartScreen extends StatefulWidget {
  const ExpressCartScreen({super.key});

  @override
  State<ExpressCartScreen> createState() => _ExpressCartScreenState();
}

class _ExpressCartScreenState extends State<ExpressCartScreen> {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.upcA],
  );

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Material(
      child: SheetMediaQuery(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Q-ExpressCart'),
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_down_1),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: const Column(
            children: [
              Text("data")
            ],
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