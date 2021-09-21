import 'package:flutter/material.dart';
import '/providers/auth.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
