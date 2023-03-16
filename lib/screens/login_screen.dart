import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/start_pages_header.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../screens/forget_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/user_profile.dart';
import '../screens/admin_control_panel.dart';
import '../components/form_input.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:cool_alert/cool_alert.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _auth = FirebaseAuth.instance ;
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
                height: 400.0,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: HeroLogo(imgHeight: 100.0),
                    ),
                    StartPagesHeader(mainText: 'LOGIN INTO YOUR ACCOUNT'),
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
                            UserCredential result = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (result.user != null) {
                              setState(() {
                                showSpinner = false;
                              });
                              var currentUid = result.user!.uid;
                              print(currentUid);
                              final CollectionReference collectionRef =
                                  FirebaseFirestore.instance
                                      .collection('Clients');
                              await collectionRef
                                  .where('uid', isEqualTo: '$currentUid')
                                  .limit(1)
                                  .get()
                                  .then((userDetail) {
                                if (userDetail.size != 0) {
                                  var currentDoc = userDetail.docs.first;
                                  print(currentDoc.id);
                                  if (currentDoc.get("is_admin") == true) {

                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AdminControlPanel.id,
                                        ModalRoute.withName('$LoginScreen.id'));
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UserProfile(
                                                userDocId: currentDoc.id),
                                      ),
                                    );
                                  }
                                }
                              });
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
                        Navigator.pushNamed(context, ForgotPassword.id);
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
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Don\'t have an account? '),
                            TextSpan(
                                text: 'SIGN UP',
                                style: TextStyle(color: mainAppColor)),
                          ],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.0),
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
  }
}
