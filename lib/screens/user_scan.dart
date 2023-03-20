import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../components/hero_logo.dart';
import '../constants.dart';

class UserScan extends StatelessWidget {
  static String id = 'user_scan_screen';
  String data = 'abdcdr';
  UserScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
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
                    titleResult: '3',
                    imagePath: 'images/paper-cup.png',
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  TextCount(
                    titleResult: '45',
                    imagePath: 'images/star.png',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextCount extends StatelessWidget {
  final String titleResult;
  final String imagePath;
  const TextCount(
      {super.key, required this.titleResult, required this.imagePath});

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
