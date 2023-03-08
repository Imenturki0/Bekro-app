import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import '../components/hero_logo.dart';
import 'user_scan.dart';

class AdminScanQr extends StatefulWidget {
  static String id = 'admin_scan_qr';
  const AdminScanQr({Key? key}) : super(key: key);

  @override
  State<AdminScanQr> createState() => _AdminScanQrState();
}

class _AdminScanQrState extends State<AdminScanQr> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
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
    return Scaffold(
      backgroundColor: mainAppColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
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
                  onTap: () {
                    Navigator.pushNamed(context, UserScan.id);
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
