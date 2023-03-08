import '../components/bottom_nav_call.dart';
import '../components/contact_form.dart';
import 'package:flutter/material.dart';
import '../components/hero_logo.dart';
import '../constants.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import '../components/map.dart';
import 'package:url_launcher/url_launcher.dart';

class TalkToUs extends StatefulWidget {
  static String id = 'talk_to_us';

  @override
  State<TalkToUs> createState() => _TalkToUsState();
}

class _TalkToUsState extends State<TalkToUs> {
  late String NameSurname;
  late String Mail;
  MapController mapController = MapController();
  LatLng currentCenter = LatLng(40.96832277164155, 29.063709644177774);
  double currentZoom = 13.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            // to scroll screen up and down easly
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      HeroLogo(imgHeight: 70.0),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Text(
                            'Work hours',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('MON-SUNDAY 10-22'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainAppColor),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Location',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Uri phoneno = Uri.parse(
                                        'https://goo.gl/maps/exch5j65hyypWFHh8');
                                    if (await launchUrl(phoneno)) {
                                      await launchUrl(phoneno);
                                    } else {
                                      throw 'Could not launch $phoneno';
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      backgroundColor: mainAppColor),
                                  child: const Text('Google maps'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Uri phoneno = Uri.parse(
                                      'https://yandex.com.tr/harita/106124/kadikoy/house/caddebostan_plajyolu_sok_8b/ZkAYdgFjQUcEQFpqfXV3eX5nZA==/?ll=29.063823%2C40.968240&z=16.47');
                                  if (await launchUrl(phoneno)) {
                                    await launchUrl(phoneno);
                                  } else {
                                    throw 'Could not launch $phoneno';
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    backgroundColor: mainAppColor),
                                child: const Text('Yandex maps'),
                              )
                            ],
                          ),
                          map(
                              mapController: mapController,
                              currentCenter: currentCenter,
                              currentZoom: currentZoom)
                        ],
                      ),
                      //  const SizedBox(height: 30),
                      contact_form()
                    ],
                  ),
                ),
                BottomNav(Text("CALL"), Text("WEBSITE"), Icon(Icons.arrow_back))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String text;
  final int maxlines;
  InputField(this.text, this.maxlines);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          hintText: text,
        ),
        maxLines: maxlines,
      ),
    );
  }
}
