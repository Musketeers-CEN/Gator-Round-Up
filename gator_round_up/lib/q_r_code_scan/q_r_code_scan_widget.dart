import 'package:gator_round_up/backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';


Future<bool?> toast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 15.0);
}

// ignore: must_be_immutable
class QRCodeScanWidget extends StatelessWidget {
  final String eventId;
  QRCodeScanWidget({Key? key, required this.eventId}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  MobileScannerController cameraController = MobileScannerController();
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          title: const Text('Mobile Scanner'),
          titleTextStyle: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Metropolis',
                color: Colors.white,
                fontSize: 22,
                useGoogleFonts: false,
              ),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
            child: MobileScanner(
                allowDuplicates: false,
                controller: cameraController,
                onDetect: (barcode, args) async {
                  if (barcode.rawValue == null) {
                    debugPrint('Failed to scan Barcode');
                  } else {
                    final String code = barcode.rawValue!;
                    String code2 = "/users/"+code;
                    debugPrint('Barcode found! $code');

                    var userRef = await FirebaseFirestore.instance.doc(code2).get();
                    // Send up user data based on event into event's Users field
                    FirebaseFirestore.instance
                      .doc(eventId).update({"Users": FieldValue.arrayUnion([userRef.reference])});

                    toast(userRef.get("email"));
                    }
                })));
  }
}

/* 
Get a drop down or eventlist working then when an individual is selected it 
1. opens qr code scanner (DONE THAT)
2. once scanned grab the data and send to the selected event into the users list if not scanned do nothing
*/