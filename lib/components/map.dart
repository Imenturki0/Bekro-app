import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class map extends StatelessWidget {
  const map({
    super.key,
    required this.mapController,
    required this.currentCenter,
    required this.currentZoom,
  });

  final MapController mapController;
  final LatLng currentCenter;
  final double currentZoom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 150,
      margin: EdgeInsets.only(top: 20.0),
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: currentCenter,
          zoom: currentZoom,
          enableScrollWheel: true,
          scrollWheelVelocity: 0.005,
        ),
        nonRotatedChildren: [],
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: currentCenter,
                width: 80,
                height: 80,
                builder: (context) => Container(
                  child: Icon(
                    Icons.location_on,
                    size: 45,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
