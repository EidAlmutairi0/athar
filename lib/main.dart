import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splashScreen.dart';
import 'screens/Login-Screen.dart';
import 'screens/SignUp-Screen.dart';
import 'providers/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:athar/screens/TourGuide_Screens/TourGuide-Main-Screen.dart';
import 'screens/User_Screens/User-Main-Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: non_constant_identifier_names

class MyApp extends StatefulWidget {
  // ignore: missing_return

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final test = Authentication();
  var userType;
  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Authentication(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'LoginScreen': (ctx) => LoginScreen(),
          'SignUpScreen': (ctx) => SignUpScreen(),
          'TourGuideHomeScreen': (ctx) => TourGuideMainScreen(),
          'UserHomeScreen': (ctx) => UserMainScreen()
        },
        theme: ThemeData(
          primaryColor: Color(0xFFF2945E),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
