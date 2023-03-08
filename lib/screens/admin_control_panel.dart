import '../components/whirl_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/rounded_button.dart';
import '../components/text_row.dart';
import '../constants.dart';

class AdminControlPanel extends StatefulWidget {
  static String id = 'admin_panel_screen';
  const AdminControlPanel({Key? key}) : super(key: key);

  @override
  State<AdminControlPanel> createState() => _AdminControlPanelState();
}

class _AdminControlPanelState extends State<AdminControlPanel> {
  String name = 'AHMET MADENOĞULLAR';
  String email = 'ahmet@gmail.com';
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: kUserAdminText,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                email,
                style: kUserAdminEmailText,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      RoundedButton(
                          borderRadius: 10,
                          textBtn: '1*',
                          onPress: () {},
                          btnWidth: 100,
                          btnHeight: 50.0),
                      const SizedBox(
                        height: 24,
                      ),
                      RoundedButton(
                          borderRadius: 10,
                          textBtn: '10*',
                          onPress: () {},
                          btnWidth: 100,
                          btnHeight: 50.0),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Cup Component'),
                      Image.asset(
                        'images/star.png',
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      TextRow(
                        title: "Reward drink",
                        titleResult: '3',
                        imagePath: 'images/paper-cup.png',
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextRow(
                        title: "Star balance",
                        titleResult: '4',
                        imagePath: 'images/star.png',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TextRow(
                title: "Whirl",
                titleResult: '0',
                imagePath: 'images/coffee-bag.png',
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    flex: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: WhirlCount(),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: RoundedButton(
                        borderRadius: 10,
                        textBtn: 'Add Whirl',
                        onPress: () {},
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
