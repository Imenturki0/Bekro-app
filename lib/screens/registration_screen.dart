import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'login_screen.dart';
import 'agreement.dart';
import 'admin_scan_qr.dart';
import 'user_profile.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/start_pages_header.dart';
import '../components/form_input.dart';
import '../models/helpers.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'register_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isLoggedIn = false;
  bool isAdmin = false;
  bool showScreen = false;
  late String name;
  late String email;
  late String password;
  late String confirmPassword;
  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();
  String? validateInputs(String? value, String inputType) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else if (inputType == 'email' && !validator.email(value)) {
      return 'Please enter a valid email';
    } else if (inputType == 'password' && value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (inputType == 'confirmPassword' && password != confirmPassword) {
      return "Passwords don't match";
    }
    return null;
  }

  void _openAlert(String title, String text, CoolAlertType alerType) {
    CoolAlert.show(
      context: context,
      type: alerType,
      title: title,
      text: text,
      loopAnimation: false,
    );
  }

  void _goToAgreement(String email, String password, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AgreementScreen(
            name: name,
            email: email,
            password: password,
          );
        },
      ),
    );
  }

  void getUserType() async {
    isLoggedIn = isUserLogged();
    if (isLoggedIn) {
      isAdmin = await isUserAdmin();
    }
    setState(
      () {
        showScreen = true;
      },
    );
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
                      height: 600.0,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Flexible(
                            child: HeroLogo(imgHeight: 100.0),
                          ),
                          const StartPagesHeader(
                              mainText: 'CREATE YOUR ACCOUNT'),
                          FormInput(
                            hintText: 'Name',
                            validatorFunction: (value) =>
                                validateInputs(value, 'name'),
                            onChangedFunction: (value) {
                              name = value;
                            },
                          ),
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
                          FormInput(
                            hintText: 'Password Confirm',
                            validatorFunction: (value) =>
                                validateInputs(value, 'confirmPassword'),
                            obsecure: true,
                            onChangedFunction: (value) {
                              confirmPassword = value;
                            },
                          ),
                          const SizedBox(height: 3.0),
                          RoundedButton(
                            borderRadius: 15.0,
                            textBtn: 'SIGN UP',
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final list = await FirebaseAuth.instance
                                      .fetchSignInMethodsForEmail(email);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  if (list.isNotEmpty) {
                                    _openAlert(
                                        'Failed',
                                        'Email Exists! please use a different one',
                                        CoolAlertType.error);
                                  } else {
                                    _goToAgreement(email, password, name);
                                  }
                                } catch (error) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  _openAlert(
                                      'Failed',
                                      'An error has occurred. please try again later',
                                      CoolAlertType.error);
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: const Text(
                              'You have an account?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.0),
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
