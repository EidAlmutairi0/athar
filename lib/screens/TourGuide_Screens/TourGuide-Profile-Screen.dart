import 'package:flutter/material.dart';
import '/providers/auth.dart';

class TourGuideProfileScreen extends StatefulWidget {
  @override
  _TourGuideProfileScreenState createState() => _TourGuideProfileScreenState();
}

class _TourGuideProfileScreenState extends State<TourGuideProfileScreen> {
  final auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile"),
          TextButton(
            child: Text('Sign Out'),
            onPressed: () {
              auth.signOut(context);
            },
          )
        ],
      ),
    );
  }
}
