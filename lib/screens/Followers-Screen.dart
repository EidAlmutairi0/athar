import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/FollowerCard.dart';

class FollowersScreen extends StatefulWidget {
  List<FollowerCard> followers;

  FollowersScreen(List<FollowerCard> a) {
    followers = a;
  }
  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        title: Text('Followers'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.followers,
          ),
        ),
      ),
    );
  }
}
