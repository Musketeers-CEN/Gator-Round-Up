import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class QRCodeScanWidget extends StatefulWidget {
  const QRCodeScanWidget({Key? key}) : super(key: key);

  @override
  _QRCodeScanWidgetState createState() => _QRCodeScanWidgetState();
}

class _QRCodeScanWidgetState extends State<QRCodeScanWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF0F0D0D),
                ),
                child: SelectionArea(
                    child: Text(
                  'USer Camera Placeholder',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Metropolis',
                        color: Colors.white,
                        useGoogleFonts: false,
                      ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
