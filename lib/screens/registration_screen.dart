import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/start_pages_header.dart';
import '../screens/login_screen.dart';
import '../screens/agreement.dart';
import '../components/form_input.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'register_screen';
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String name;
  late String email;
  late String password;
  late String confirmPassword;
  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
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
                    Flexible(
                      child: HeroLogo(imgHeight: 100.0),
                    ),
                    StartPagesHeader(mainText: 'CREATE YOUR ACCOUNT'),
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
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                title: 'Failed',
                                text:
                                    'Email Already Exists! please use a different one',
                                loopAnimation: false,
                              );
                            } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AgreementScreen(
                                  name: name,
                                  email: email,
                                  password: password,
                                );
                              }));
                            }
                          } catch (error) {
                            setState(() {
                              showSpinner = false;
                            });
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: 'Failed',
                              text:
                                  'An error has occurred. please try again later',
                              loopAnimation: false,
                            );
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
    );
  }
}
