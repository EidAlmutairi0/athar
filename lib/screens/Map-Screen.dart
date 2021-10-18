import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/globals.dart' as globals;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapToolbarEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          markers: globals.places,
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(globals.latitude, globals.longitude),
          ),
        ),
      ),
    );
  }
}
