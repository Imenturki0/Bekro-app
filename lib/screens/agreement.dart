import 'package:bekron_app/screens/user_profile.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/agreement_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/helpers.dart';

class AgreementScreen extends StatefulWidget {
  //static String id = 'agreement';

  const AgreementScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.password});
  final String name;
  final String email;
  final String password;

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  //final _auth = FirebaseAuth.instance ;
  final _fireStore = FirebaseFirestore.instance;
  bool showSpinner = false;
  final ScrollController controller = ScrollController();

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
  }
  void _openMyPage(String userDocId) {
    Navigator.push (
      context,
      MaterialPageRoute (
        builder: (BuildContext context) =>  UserProfile(userDocId: userDocId ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: HeroLogo(imgHeight: 90.0),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                flex: 9,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: const EdgeInsets.fromLTRB(6, 6, 6, 20),
                      padding: const EdgeInsets.fromLTRB(16, 26, 0, 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFEEEFEF),
                      ),
                      child: Column(
                        children: const <Widget>[
                          Expanded(
                            child: RawScrollbar(
                              thumbColor: Color(0xFF414042),
                              child: SingleChildScrollView(
                                  padding: EdgeInsets.only(right: 22),
                                  scrollDirection: Axis.vertical,
                                  child: AgreementText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      borderRadius: 15.0,
                      textBtn: 'I have read and I approve',
                      onPress: () async {
                        setState(() {
                        showSpinner = true;
                        });
                       try {
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: widget.email,
                            password: widget.password,
                          );
                          User? updateUser = FirebaseAuth.instance.currentUser;
                          updateUser?.updateDisplayName(widget.name);

                          final userDocId = await userSetup(widget.name);
                          _openMyPage(userDocId );
                        setState(() {
                        showSpinner = false;
                        });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> signUpWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    return user!.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else {
      return e.message!;
    }
  } catch (e) {
    return e.toString();
  }
}

