import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'user_profile.dart';
import 'admin_scan_qr.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../models/helpers.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';

  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoggedIn = false;
  bool isAdmin = false;
  bool showScreen = false;

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
    if (!showScreen) {
      getUserType();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showScreen && isLoggedIn && isAdmin) {
      return const AdminScanQr();
    } else if (showScreen && isLoggedIn && !isAdmin) {
      return const UserProfile();
    } else if (showScreen && !isLoggedIn) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                            child: HeroLogo(imgHeight: 160.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      RoundedButton(
                        borderRadius: 8.0,
                        textBtn: 'LOGIN',
                        onPress: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                      ),
                      RoundedButton(
                        borderRadius: 8.0,
                        textBtn: 'SIGN-UP',
                        onPress: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        },
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
}
