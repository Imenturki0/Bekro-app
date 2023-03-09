import '../components/whirl_count.dart';
import 'package:flutter/material.dart';
import '../components/hero_logo.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class UserProfile extends StatefulWidget {
  static String id = 'user_profile_screen';
  const UserProfile({Key? key}) : super(key: key);
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String data = 'abdcdr';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(child: HeroLogo(imgHeight: 70.0)),
            const SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hi,Ahmad',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
                RoundedButton(
                    borderRadius: 10, textBtn: 'logout', onPress: () {}),
              ],
            ),
            const Expanded(
              child: Center(
                child: Text('Cup Component',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
              ),
            ),
            // expanded
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    TextRow(
                      title: "Reward drink",
                      titleResult: '3',
                      imagePath: 'images/paper-cup.png',
                    ),
                    TextRow(
                      title: "Star balance",
                      titleResult: '4',
                      imagePath: 'images/star.png',
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: RoundedButton(
                borderRadius: 10.0,
                textBtn: 'SCAN QR',
                onPress: () {
                  _showFullModal(context, data);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextRow(
                  title: "Whirl",
                  titleResult: '0',
                  imagePath: 'images/paper-cup.png'),
            ),
            // WhirlIconWidget(
            //   whirlCount: 10,
            // ) ,
            const Expanded(
              child: SizedBox(
                width: double.infinity,
                child: WhirlCount(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextRow extends StatelessWidget {
  final String title;
  final String titleResult;
  final String imagePath;
  const TextRow(
      {super.key,
      required this.title,
      required this.titleResult,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Text(
            title,
            style: kUserProfileText,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(titleResult, style: kUserProfileText),
          const SizedBox(
            width: 6,
          ),
          Image.asset(
            imagePath,
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }
}

dynamic _showFullModal(context, String data) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    barrierLabel: "Modal", // label for barrier
    transitionDuration: const Duration(
        milliseconds:
            500), // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // your widget implementation
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            elevation: 0.0),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: HeroLogo(imgHeight: 100.0),
              ),
              Center(
                  child: BarcodeWidget(
                data: data,
                barcode: Barcode.qrCode(),
                color: Colors.black87,
                height: 250,
                width: 250,
                margin: const EdgeInsets.only(top: 40),
              )),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    TextCount(
                        titleResult: '3', imagePath: 'images/paper-cup.png'),
                    SizedBox(
                      width: 32,
                    ),
                    TextCount(titleResult: '45', imagePath: 'images/star.png'),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class TextCount extends StatelessWidget {
  final String titleResult;
  final String imagePath;
  const TextCount({required this.titleResult, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Text(titleResult, style: kUserScanText),
          const SizedBox(
            width: 16,
          ),
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }
}
