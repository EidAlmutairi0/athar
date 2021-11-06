import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';

class UserInfoProvider with ChangeNotifier {
  FirebaseFirestore database = FirebaseFirestore.instance;
  bool userType = Authentication.TourGuide;

  String nickName;

  getUserNickname() async {
    if (userType) {
      await database
          .collection('users')
          .doc('tourGuides')
          .collection('tourGuides')
          .doc(Authentication.currntUsername)
          .get()
          .then((value) {
        nickName = value.get('name');
        notifyListeners();
      });
    } else {
      await database
          .collection('users')
          .doc('normalUsers')
          .collection('normalUsers')
          .doc(Authentication.currntUsername)
          .get()
          .then((value) {
        nickName = value.get('name');
        notifyListeners();
      });
    }
  }
}
