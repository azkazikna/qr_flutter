import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  bool _flashOn = false;
  bool _frontCam = false;
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: _qrKey,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
            onQRViewCreated: (QRViewController controller) {
              this.controller = controller;
              controller.scannedDataStream.listen((scanData) {
                if (mounted) {
                  controller.dispose();
                  Navigator.pop(context, scanData.code);
                }
              });
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 60),
              child: const Text(
                'Scanner',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    color: Colors.white,
                    icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                    onPressed: () {
                      setState(() {
                        _flashOn = !_flashOn;
                        controller?.toggleFlash();
                      });
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(
                        _frontCam ? Icons.camera_front : Icons.camera_rear),
                    onPressed: () {
                      setState(() {
                        _frontCam = !_frontCam;
                      });
                      controller?.flipCamera();
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
