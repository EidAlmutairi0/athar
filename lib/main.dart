import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splashScreen.dart';
import 'screens/Login-Screen.dart';
import 'screens/SignUp-Screen.dart';
import 'providers/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:athar/screens/TourGuide_Screens/TourGuide-Main-Screen.dart';
import 'screens/User_Screens/User-Main-Screen.dart';
import 'package:geolocator/geolocator.dart';
import 'Widgets/PlaceCard.dart';
import 'globals.dart' as globals;

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
  @override
  void initState() {
    _determinePosition().then((value) {
      if (value != null) {
        setState(() {
          globals.latitude = value.latitude;
          globals.longitude = value.longitude;
          print(globals.latitude);
          print(globals.longitude);
        });
      }
    });

    super.initState();
  }

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

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return null;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
