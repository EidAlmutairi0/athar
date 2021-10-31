import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowerProvider with ChangeNotifier {
  bool isFollow = false;
  String text = 'follow';
  Color color = Colors.white;
  Color contColor = Color(0xFFF2945E);

  follow() {
    isFollow = true;
    text = 'following';
    color = Colors.white;
    contColor = Color(0xFFF2945E);
    notifyListeners();
  }

  unFollow() {
    isFollow = false;
    text = 'follow';
    color = Color(0xFFF2945E);
    contColor = Colors.white;
    notifyListeners();
  }
}
