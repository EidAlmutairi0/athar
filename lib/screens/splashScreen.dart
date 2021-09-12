import 'dart:async';

import 'package:flutter/material.dart';
import '/providers/auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final test = Authentication();

  @override
  void initState() {
    test.autoLogin().whenComplete(() async {
      Timer(
          Duration(milliseconds: 1500),
          () => {
                // ignore: unrelated_type_equality_checks
                if (test.isAuth())
                  {
                    Navigator.pushReplacementNamed(context, "UserHomeScreen"),
                  }
                else
                  {
                    Navigator.pushReplacementNamed(context, 'LoginScreen'),
                  }
              });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2945E),
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
