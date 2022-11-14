import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  DateTimeRange? calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Gator Round Up',
          style: TextStyle(
            fontFamily: 'Casa Pinada',
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 33,
          ),
        ),
        actions: [
          FFButtonWidget(
            onPressed: () async {
              context.pushNamedAuth(
                'Sign_In',
                mounted,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                  ),
                },
              );

              GoRouter.of(context).prepareAuthEvent();
              await signOut();
            },
            text: 'Sign Out',
            options: FFButtonOptions(
              width: 130,
              height: 40,
              color: FlutterFlowTheme.of(context).primaryColor,
              textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Metropolis',
                    color: Colors.white,
                    useGoogleFonts: false,
                  ),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed('QRCode');
                    },
                    text: 'QR Code',
                    options: FFButtonOptions(
                      width: 180,
                      height: 80,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Metropolis',
                                color: Colors.white,
                                useGoogleFonts: false,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (valueOrDefault<bool>(currentUserDocument?.admin, false))
                    AuthUserStreamWidget(
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed('QRCodeScan');
                        },
                        text: 'Scan QR Code',
                        options: FFButtonOptions(
                          width: 140,
                          height: 80,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Metropolis',
                                    color: Colors.white,
                                    useGoogleFonts: false,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  if (valueOrDefault<bool>(currentUserDocument?.admin, false))
                    AuthUserStreamWidget(
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed('QRCodeScan');
                        },
                        text: 'Create Event',
                        options: FFButtonOptions(
                          width: 140,
                          height: 80,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Metropolis',
                                    color: Colors.white,
                                    useGoogleFonts: false,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectionArea(
                      child: Text(
                    '',
                    style: FlutterFlowTheme.of(context).bodyText1,
                  )),
                ],
              ),
              FlutterFlowCalendar(
                color: FlutterFlowTheme.of(context).primaryColor,
                weekFormat: false,
                weekStartsMonday: true,
                onChange: (DateTimeRange? newSelectedDate) {
                  setState(() => calendarSelectedDay = newSelectedDate);
                },
                titleStyle: TextStyle(),
                dayOfWeekStyle: TextStyle(),
                dateStyle: TextStyle(),
                selectedDateStyle: TextStyle(),
                inactiveDateStyle: TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
