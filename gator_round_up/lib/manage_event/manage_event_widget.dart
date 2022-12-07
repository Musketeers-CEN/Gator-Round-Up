
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

String eventTitle = "Loading...";

class ManageEventWidget extends StatelessWidget {
  final String eventId;
  ManageEventWidget({Key? key, required this.eventId}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    int epicLength = -1;
    List<String> strArr = [];

    Future<DocumentSnapshot?>? asyncFunction() async {
      if (eventId == "") {
        return null;
      }

      DocumentSnapshot document = await FirebaseFirestore.instance.doc(eventId).get();

      if(document.exists){
        var Users = document.get("Users");
        epicLength = Users.length;

        for(var userRef in Users){
          DocumentSnapshot userSnap = await userRef.get();
          if (userSnap.exists) {
            String email = userSnap.get("email");
            if(!strArr.contains(email)){
              strArr.add(email);
            }
          }
          else{
            print("User no existo");
          }
        }
      }
      else {
        throw ('Document does not exist on the database');
      }

      return document;
    }

    return FutureBuilder<DocumentSnapshot?>(
        future: asyncFunction(),
        builder: (context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
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
                            itemCount: strArr.length,
                            itemBuilder: (context, int index) {
                              return ListTile(
                                title: Text(
                                  strArr[index], //userRefToName(listViewEventsRecord.toString()),
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
