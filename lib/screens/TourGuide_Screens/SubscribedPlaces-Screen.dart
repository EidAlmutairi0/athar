import 'package:flutter/material.dart';

class SubscribedPlaces extends StatelessWidget {
  List places;
  SubscribedPlaces(List places) {
    this.places = places;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscribed Places'),
        centerTitle: true,
        backgroundColor: Color(0xFFF2945E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: places,
        ),
      ),
    );
  }
}
