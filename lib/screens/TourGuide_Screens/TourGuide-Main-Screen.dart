import 'package:athar/screens/TourGuide_Screens/TourGuide-Profile-Screen.dart';
import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../TourGuide_Screens/TourGuide-Home-Screen.dart';
import '../Map-Screen.dart';
import '../TourGuide_Screens/TourGuide-Profile-Screen.dart';

class TourGuideMainScreen extends StatefulWidget {
  @override
  State<TourGuideMainScreen> createState() => _TourGuideMainScreenState();
}

class _TourGuideMainScreenState extends State<TourGuideMainScreen> {
  final auth = Authentication();
  int selectedScreen = 1;
  final _Screens = [
    TourGuideProfileScreen(),
    TourGuideHomeScreen(),
    MapScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xFFF2945E),
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.person),
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.map),
        ],
        initialActiveIndex: 1,
        onTap: (int i) {
          setState(() {
            selectedScreen = i;
          });
        },
      ),
      body: _Screens[selectedScreen],
    );
  }
}
