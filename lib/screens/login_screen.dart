import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:cool_alert/cool_alert.dart';
import 'forget_screen.dart';
import 'registration_screen.dart';
import 'user_profile.dart';
import 'admin_scan_qr.dart';
import 'email_verification.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/start_pages_header.dart';
import '../components/form_input.dart';
import '../models/helpers.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  bool isAdmin = false;
  bool showScreen = false;
  late String email;
  late String password;
  bool showSpinner = false;
  final newCollection = FirebaseFirestore.instance.collection('Clients');

  final _formKey = GlobalKey<FormState>();
  String? validateInputs(String? value, String inputType) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else if (inputType == 'email' && !validator.email(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void _goToLink(String pageId) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      pageId,
      ModalRoute.withName('$LoginScreen.id'),
    );
  }

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
            child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 10.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 400.0,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Flexible(
                            child: HeroLogo(imgHeight: 100.0),
                          ),
                          const StartPagesHeader(
                              mainText: 'LOGIN INTO YOUR ACCOUNT'),
                          FormInput(
                            hintText: 'Email',
                            validatorFunction: (value) =>
                                validateInputs(value, 'email'),
                            onChangedFunction: (value) {
                              email = value;
                            },
                          ),
                          FormInput(
                            hintText: 'Password',
                            validatorFunction: (value) =>
                                validateInputs(value, 'password'),
                            obsecure: true,
                            onChangedFunction: (value) {
                              password = value;
                            },
                          ),
                          const SizedBox(height: 3.0),
                          RoundedButton(
                            borderRadius: 15.0,
                            textBtn: 'LogIn',
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  UserCredential result = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  var user = result.user;
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  if (user!.emailVerified == false) {
                                    _goToLink(EmailVerification.id);
                                  } else {
                                    final userInfo =
                                        await getUserData(user.uid);
                                    if (userInfo.isNotEmpty) {
                                      if (userInfo['is_admin'] == true) {
                                        _goToLink(AdminScanQr.id);
                                      } else {
                                        _goToLink(UserProfile.id);
                                      }
                                    }
                                  }
                                } catch (e) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    title: 'Failed',
                                    text: 'You entered wrong information',
                                    loopAnimation: false,
                                  );
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 10.0),
                          GestureDetector(
                            onTap: () {
                              _goToLink(ForgotPassword.id);
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.0),
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          GestureDetector(
                            onTap: () {
                              _goToLink(RegistrationScreen.id);
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Don\'t have an account? ',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                    text: 'SIGN UP',
                                    style: TextStyle(color: mainAppColor),
                                  ),
                                ],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
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
