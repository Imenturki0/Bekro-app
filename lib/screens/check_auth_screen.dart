import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'user_profile.dart';
import 'admin_scan_qr.dart';
import '../models/helpers.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;
    bool isAdmin = false;
    void getUserType() async {
      isLoggedIn = isUserLogged();
      isAdmin = await isUserAdmin();
    }

    getUserType();
    Widget firstWidget;
    if (isLoggedIn && isAdmin) {
      firstWidget = const AdminScanQr();
    } else if (isLoggedIn && !isAdmin) {
      firstWidget = const UserProfile();
    } else {
      firstWidget = const MainScreen();
    }
    return Scaffold(body: firstWidget);
  }
}
