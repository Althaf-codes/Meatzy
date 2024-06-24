import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  static const double _defaulLat = 11.92148377563544;
  static const double _defaultLng = 79.62854114224366;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(zoom: 18, target: LatLng(_defaulLat, _defaultLng)),
        )
      ]),
    );
  }
}
