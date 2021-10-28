import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'package:flutter/material.dart';

class FavoritePlaceProvider with ChangeNotifier {
  Color likeColor = Colors.grey;

  Future<bool> isLiked(String place, String user, bool isTourGuide) async {
    if (isTourGuide == true) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('tourGuides')
          .collection('tourGuides')
          .doc(user)
          .collection('FavoritePlaces')
          .doc(place)
          .get()
          .then((value) {
        if (value.exists) {
          likeColor = Colors.redAccent;
          notifyListeners();
          return true;
        } else {
          likeColor = Colors.grey;
          notifyListeners();
          return false;
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('normalUsers')
          .collection('normalUsers')
          .doc(user)
          .collection('FavoritePlaces')
          .doc(place)
          .get()
          .then((value) {
        if (value.exists) {
          likeColor = Colors.redAccent;
          notifyListeners();
          return true;
        } else {
          likeColor = Colors.grey;
          notifyListeners();
          return false;
        }
      });
    }
  }

  Future<bool> onLikeButtonTapped(String place, String image, String user,
      bool isTourGuide, bool isLike) async {
    if (isLike) {
      if (isTourGuide == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(user)
            .collection('FavoritePlaces')
            .doc(place)
            .set({
          'PlaceName': place,
          'image': image,
        });
        likeColor = Colors.redAccent;
        notifyListeners();
        return true;
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(user)
            .collection('FavoritePlaces')
            .doc(place)
            .set({
          'PlaceName': place,
          'image': image,
        });
        likeColor = Colors.redAccent;
        notifyListeners();
        return true;
      }
    } else {
      if (isTourGuide == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(user)
            .collection('FavoritePlaces')
            .doc(place)
            .delete();
        likeColor = Colors.grey;
        notifyListeners();
        return false;
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(user)
            .collection('FavoritePlaces')
            .doc(place)
            .delete();
        likeColor = Colors.grey;
        notifyListeners();
        return false;
      }
    }
  }
}
