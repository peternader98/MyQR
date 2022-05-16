import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            Positioned(bottom: 15.0, child: buildResult()),
            Positioned(top: 15.0, child: buildControlButtons()),
          ],
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderLength: 20.0,
        borderWidth: 10.0,
        borderRadius: 10.0,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
  );

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        barcode = scanData;
      });
    });
  }

  Widget buildControlButtons() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white24,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: FutureBuilder<bool?>(
            future: controller?.getFlashStatus(),
            builder: (context, snapshot){
              if(snapshot.data != null){
                return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off);
              }
              else {
                return Container();
              }
            },
          ),
          onPressed: () async {
            await controller?.toggleFlash();
            setState(() {});
          },
        ),
        IconButton(
          icon: FutureBuilder(
            future: controller?.getCameraInfo(),
            builder: (context, snapshot){
              if(snapshot.data != null) {
                return const Icon(Icons.switch_camera);
              }
              else {
                return Container();
              }
            },
          ),
          onPressed: () async {
            await controller?.flipCamera();
            setState(() {});
          },
        ),
      ],
    ),
  );

  Widget buildResult() => Container(
    padding: const EdgeInsets.all(12.0),
    width: MediaQuery.of(context).size.width * 0.9,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white24,
    ),
    child: Text(
      barcode != null ? '${barcode!.code}' : 'Scan a code',
      maxLines: 3,
    ),
  );

}
