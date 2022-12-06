import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

String eventTitle = "Loading...";

class ManageEventWidget extends StatelessWidget {
  final String eventId;
  ManageEventWidget({Key? key, required this.eventId}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<dynamic> group = [];

    Future<DocumentSnapshot>? asyncFunction() {
      print("HERE2");

      if (eventId == "") {
        return null;
      }

      Future<DocumentSnapshot> document = FirebaseFirestore.instance
          .doc(eventId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return documentSnapshot;
        } else {
          throw ('Document does not exist on the database');
        }
      });
      return document;
    }

    String userRefToName(String ref) {
      //remove extra info
      ref = ref.substring(ref.indexOf('(') + 1, ref.indexOf(')'));

      debugPrint("Ref: " + ref);
      Future<DocumentSnapshot> name = FirebaseFirestore.instance
          .doc(ref)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return documentSnapshot;
        } else {
          throw ('Document does not exist on the database');
        }
      });

      String result = "";
      name.then((DocumentSnapshot doc) {
        debugPrint(doc.get("display_name"));
        result = doc.get("display_name");
      });

      return result;
    }

    //document is still not being found

    /*Future<List<dynamic>> document = FirebaseFirestore.instance
        .doc(eventId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print("HERE");
        eventTitle = documentSnapshot.get("EventTitle");
        print(eventTitle);
        return group = documentSnapshot.get("Users");
      } else {
        throw ('Document does not exist on the database');
      }
    });*/

    return FutureBuilder<DocumentSnapshot>(
        future: asyncFunction(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                automaticallyImplyLeading: true,
                title: Text(
                  snapshot.data?.get("EventTitle"),
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
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.get("Users").length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewEventsRecord =
                                  snapshot.data?.get("Users")[listViewIndex];
                              return ListTile(
                                title: Text(
                                  listViewEventsRecord
                                      .toString(), //userRefToName(listViewEventsRecord.toString()),
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Metropolis',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        useGoogleFonts: false,
                                      ),
                                ),
                                tileColor: Color(0xFFF5F5F5),
                                dense: false,
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
          } else {
            return CircularProgressIndicator();
          }
        });
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
