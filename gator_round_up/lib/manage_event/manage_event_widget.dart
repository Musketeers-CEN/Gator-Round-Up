import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

String eventId = "";
class ManageEventWidget extends StatelessWidget  {
  
  final String eventId;
  ManageEventWidget({Key? key, required this.eventId}) : super(key: key);


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String docID = ModalRoute.of(context)!.settings.arguments.toString();

    List<DocumentReference> group = [];

    Future<DocumentReference<Map<String, dynamic>>> document = FirebaseFirestore
        .instance
        .collection('Events')
        .doc(docID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        group = documentSnapshot.get("Users");
      } else {
        throw ('Document does not exist on the database');
      }
      throw ('Document does not exist on the database');
    });
    List<String> userNames = [];
    group.forEach(
      (element) {
        String name = '';
        FirebaseFirestore.instance
            .collection("Users")
            .doc(element.path)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          name = documentSnapshot.get('displayname');
        });

        userNames.add(name);
      },
    );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          eventId,
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
                  Text("Event Title:"),
                  ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: userNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: Center(child: Text('Entry ${userNames[index]}')),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
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