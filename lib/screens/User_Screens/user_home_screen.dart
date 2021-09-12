import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class UserHomeScreen extends StatelessWidget {
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
        title: Text("User"),
        centerTitle: true,
        backgroundColor: Color(0xFFF2945E),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xFFF2945E),
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.person),
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.map),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => print('click index=$i'),
      ),
      body: Container(),
    );
  }
}
