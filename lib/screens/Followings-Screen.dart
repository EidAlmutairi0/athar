import 'package:flutter/material.dart';
import '../Widgets/FollowerCard.dart';

class FollowingsScreen extends StatefulWidget {
  List<FollowerCard> followings;

  FollowingsScreen(List<FollowerCard> a) {
    followings = a;
  }

  @override
  _FollowingsScreenState createState() => _FollowingsScreenState();
}

class _FollowingsScreenState extends State<FollowingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        title: Text('Followings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.followings,
          ),
        ),
      ),
    );
  }
}
