import 'package:flutter/material.dart';
import '/providers/auth.dart';

class TourGuideHomeScreen extends StatelessWidget {
  final auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            auth.signOut(context);
          },
        ),
        title: Text("TourGuide"),
        backgroundColor: Color(0xFFF2945E),
      ),
      body: Container(),
    );
  }
}
