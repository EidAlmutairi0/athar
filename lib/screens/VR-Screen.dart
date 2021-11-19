import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class VRScreen extends StatelessWidget {
  String placeName;
  List VRimages;

  VRScreen(var placeName, List images) {
    this.placeName = placeName;
    VRimages = images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(placeName),
        centerTitle: true,
        backgroundColor: Color(0xFFF2945E),
      ),
      body: Center(
        child: Panorama(child: Image.network(VRimages[2])),
      ),
    );
  }
}
