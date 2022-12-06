import 'dart:html';
import 'package:gator_round_up/index.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScanWidget extends StatefulWidget {
  const QRCodeScanWidget({Key? key}) : super(key: key);

  @override
  _QRCodeScanWidgetState createState() => _QRCodeScanWidgetState();
}

/* Get a drop down or eventlist working then when an individual is selected it 
1. opens qr code scanner (DONE THAT)
2. once scanned grab the data and send to the selected event into the users list
if not scanned do nothing

*/

class _QRCodeScanWidgetState extends State<QRCodeScanWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();      
      
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
            }
          }),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'QR Code of User',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Metropolis',
                color: Colors.white,
                fontSize: 22,
                useGoogleFonts: false,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [QRCodeScanWidget()],
          ),
        ),
      ),
    );
  }*/
}
