import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier {
  static String currntUserEmail;
  static String currntUsername;
  static bool TourGuide;
  int istureGuide;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var dataBase = FirebaseFirestore.instance;

  void sendResetEmail(String email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  bool isAuth() {
    if (currntUserEmail != null) return true;
    return false;
  }

  bool userType() {
    if (istureGuide == 0) return true;
    return false;
  }

  Future<String> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("email") == false) {
      return null;
    }
    currntUserEmail = prefs.getString('email');
    istureGuide = prefs.getInt('userType');
    if (istureGuide == 0) TourGuide = true;
    if (istureGuide == 1) TourGuide = false;
    currntUsername = prefs.getString('userName');
    return currntUserEmail;
  }

  Future<String> signUp(String email, String password, String userName,
      bool isTourGuide, context) async {
    String mess;
    try {
      var checkUername = await dataBase
          .collection("users")
          .doc('normalUsers')
          .collection("normalUsers")
          .doc('$userName')
          .get();
      if (checkUername.exists) {
        mess = "Username already exists";
        return mess;
      }

      var checkTourname = await dataBase
          .collection("users")
          .doc('tourGuides')
          .collection("tourGuides")
          .doc('$userName')
          .get();
      if (checkTourname.exists) {
        mess = "Username already exists";
        return mess;
      } else {
        await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          if (isTourGuide) {
            dataBase
                .collection("users")
                .doc('tourGuides')
                .collection("tourGuides")
                .doc('$userName')
                .set({
              'email': email,
              'password': password,
              'userName': userName,
              'name': userName,
              'avatar': "",
              'header': "",
              'isTourGuide': true,
              'ContactInfo': "",
              'expiryDate': "2000-01-01"
            });
            mess = "tourGuide signed up";
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('email', _firebaseAuth.currentUser.email);
            prefs.setString('userName', currntUsername);
            currntUsername = userName;
            currntUserEmail = email;
            TourGuide = true;
            prefs.setInt("userType", 0);
            notifyListeners();
            return mess;
          } else {
            dataBase
                .collection("users")
                .doc('normalUsers')
                .collection("normalUsers")
                .doc('$userName')
                .set({
              'email': email,
              'name': userName,
              'password': password,
              'userName': userName,
              'avatar': "",
              'header': "",
              'isTourGuide': false,
            });
            mess = "user signed up";
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('email', _firebaseAuth.currentUser.email);
            prefs.setString('userName', currntUsername);
            currntUsername = userName;
            currntUserEmail = email;
            TourGuide = false;
            prefs.setInt("userType", 1);
            notifyListeners();
            return mess;
          }
        });
      }
      currntUserEmail = _firebaseAuth.currentUser.email;
      currntUsername = userName;
      return mess;
    } catch (e) {
      return e.message;
    }
  }

  Future<String> signIn(String email, String password, context) async {
    try {
      var checkuser = await dataBase
          .collection("users")
          .doc('normalUsers')
          .collection("normalUsers")
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        return value.docs.isEmpty;
      });
      // ignore: unrelated_type_equality_checks
      if (!checkuser) {
        await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          currntUserEmail = _firebaseAuth.currentUser.email;
          TourGuide = false;
          final prefs = await SharedPreferences.getInstance();
          dataBase
              .collection("users")
              .doc('normalUsers')
              .collection("normalUsers")
              .where('email', isEqualTo: _firebaseAuth.currentUser.email)
              .get()
              .then((value) => {currntUsername = value.docs.first.id})
              .then((value) => {
                    prefs.setString('email', _firebaseAuth.currentUser.email),
                    prefs.setString('userName', currntUsername),
                    prefs.setInt("userType", 1),
                  });

          notifyListeners();
          Navigator.pushNamedAndRemoveUntil(
              context, "UserHomeScreen", (r) => false);
        });

        return "Logged in";
      }
      return "not user";
    } catch (e) {
      return e.message;
    }
  }

  Future<String> tourGuidesignIn(String email, String password, context) async {
    try {
      var checkuser = await dataBase
          .collection("users")
          .doc('tourGuides')
          .collection("tourGuides")
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        return value.docs.isEmpty;
      });
      // ignore: unrelated_type_equality_checks
      if (!checkuser) {
        await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          currntUserEmail = _firebaseAuth.currentUser.email;
          TourGuide = true;
          final prefs = await SharedPreferences.getInstance();
          dataBase
              .collection("users")
              .doc('tourGuides')
              .collection("tourGuides")
              .where('email', isEqualTo: _firebaseAuth.currentUser.email)
              .get()
              .then((value) => {currntUsername = value.docs.first.id})
              .then((value) => {
                    prefs.setString('email', _firebaseAuth.currentUser.email),
                    prefs.setString('userName', currntUsername),
                    prefs.setInt("userType", 0),
                  });
          notifyListeners();

          Navigator.pushNamedAndRemoveUntil(
              context, "TourGuideHomeScreen", (r) => false);
        });
        return "Logged in";
      }
      return "not user";
    } catch (e) {
      return e.message;
    }
  }

  void signOut(context) async {
    final prefs = await SharedPreferences.getInstance();

    _firebaseAuth.signOut().then((value) {
      Navigator.pushReplacementNamed(context, "LoginScreen");
      prefs.clear();
    });
  }
}
