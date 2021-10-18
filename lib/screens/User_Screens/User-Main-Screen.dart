import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'User-Home-Screen.dart';
import '../Map-Screen.dart';
import 'User-Profile-Screen.dart';

class UserMainScreen extends StatefulWidget {
  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  final auth = Authentication();
  int selectedScreen = 1;
  final _Screens = [UserProfileScreen(), UserHomeScreen(), MapScreen()];

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
