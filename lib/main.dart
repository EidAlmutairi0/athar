import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/Login-Screen.dart';
import 'screens/SignUp-Screen.dart';
import 'providers/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:athar/screens/TourGuide_Screens/tourguide_home_screen.dart';
import 'package:athar/screens/User_Screens/user_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'LoginScreen': (ctx) => LoginScreen(),
          'SignUpScreen': (ctx) => SignUpScreen(),
          'TourGuideHomeScreen': (ctx) => TourGuideHomeScreen(),
          'UserHomeScreen': (ctx) => UserHomeScreen()
        },
        theme: ThemeData(
          primaryColor: Color(0xFFF2945E),
        ),
        home: Center(child: LoginScreen()));
  }
}
