import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:async';
import 'package:majascan/majascan.dart';
import 'admin_control_panel.dart';
import 'main_screen.dart';
import 'user_profile.dart';
import '../components/hero_logo.dart';
import '../models/helpers.dart';
import '../constants.dart';

class AdminScanQr extends StatefulWidget {
  static String id = 'admin_scan_qr';
  const AdminScanQr({Key? key}) : super(key: key);

  @override
  State<AdminScanQr> createState() => _AdminScanQrState();
}

class _AdminScanQrState extends State<AdminScanQr> {
  bool isLoggedIn = false;
  bool isAdmin = false;
  bool showScreen = false;
  String result = "";

  void getUserType() async {
    isLoggedIn = isUserLogged();
    if (isLoggedIn) {
      isAdmin = await isUserAdmin();
    }
    setState(() {
      showScreen = true;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    if (!showScreen) {
      getUserType();
    }
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (showScreen && isLoggedIn && !isAdmin) {
      return const UserProfile();
    } else if (showScreen && !isLoggedIn) {
      return const MainScreen();
    } else if (showScreen && isLoggedIn && isAdmin) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: mainAppColor,
          body: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Expanded(
                            child: HeroLogo(imgHeight: 150.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(500.0),
                            onTap: () async {
                              await _scanQR();
                              if (result.isNotEmpty &&
                                  result.contains('user')) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(
                                  context,
                                  AdminControlPanel.id,
                                  arguments: {'qrcode': result},
                                );
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(500.0),
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushNamed(context, MainScreen.id);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
                              child: Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: true,
          child: SizedBox(),
        ),
      );
    }
  }

  Future _scanQR() async {
    try {
      String? qrResult = await MajaScan.startScan(
          title: "QRcode scanner",
          titleColor: Colors.amberAccent[700],
          qRCornerColor: Colors.orange,
          qRScannerColor: Colors.orange);
      setState(() {
        result = qrResult ?? 'null string';
      });
    } on PlatformException catch (ex) {
      if (ex.code == MajaScan.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }
}
