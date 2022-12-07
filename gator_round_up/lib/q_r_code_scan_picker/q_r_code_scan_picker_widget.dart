import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class QRCodeScanPickWidget extends StatefulWidget {
  const QRCodeScanPickWidget({Key? key}) : super(key: key);

  @override
  _QRCodeScanPckState createState() => _QRCodeScanPckState();
}

Future<void> scanQR() async {
  String barcodeScanRes;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    print(barcodeScanRes);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  }
}

class _QRCodeScanPckState extends State<QRCodeScanPickWidget> {
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
          'Manage Events',
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
              Column(
                //Event List
                mainAxisSize: MainAxisSize.max,
                children: [
                  StreamBuilder<List<EventsRecord>>(
                    stream: queryEventsRecord(
                      queryBuilder: (eventsRecord) =>
                          eventsRecord.orderBy('StartTime'),
                      limit: 20,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      List<EventsRecord> listViewEventsRecordList =
                          snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewEventsRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewEventsRecord =
                              listViewEventsRecordList[listViewIndex];
                          return InkWell(
                            onTap: () async {
                              /*To do: generate qr code based on user ID */
                              context.pushNamed('QRCodeScan', params: {
                                "eventId":
                                    listViewEventsRecord.reference.path
                              });
                            },
                            child: ListTile(
                              title: Text(
                                listViewEventsRecord.eventTitle!,
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Metropolis',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              subtitle: Text(
                                '${dateTimeFormat('jm', listViewEventsRecord.startTime)} ${dateTimeFormat('MMMEd', listViewEventsRecord.eventDate)}',
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Metropolis',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              tileColor: Color(0xFFF5F5F5),
                              dense: false,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
