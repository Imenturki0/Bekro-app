//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../components/hero_logo.dart';
import '../components/agreement_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AgreementScreen extends StatefulWidget {
  //static String id = 'agreement';

  AgreementScreen(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password});
  final String name;
  final String email;
  final String phone;
  final String password;

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  //final _auth = FirebaseAuth.instance ;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: HeroLogo(imgHeight: 90.0),
              ),
              SizedBox(height: 10.0),
              Expanded(
                flex: 9,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.fromLTRB(6, 6, 6, 20),
                      padding: EdgeInsets.fromLTRB(16, 26, 0, 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFEEEFEF),
                      ),
                      child: Expanded(
                        child: RawScrollbar(
                          thumbColor: Color(0xFF414042),
                          child: SingleChildScrollView(
                              padding: EdgeInsets.only(right: 22),
                              scrollDirection: Axis.vertical,
                              child: AgreementText),
                        ),
                      ),
                    ),
                    RoundedButton(
                      borderRadius: 15.0,
                      textBtn: 'I have read and I approve',
                      onPress: () async {
                        /*setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth
                          .createUserWithEmailAndPassword(
                          email: email, password: password);
                      if(newUser != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch(e){print(e);}*/
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
