import 'package:flutter/material.dart';

class FolloerReixews extends StatefulWidget {
  List reviews;

  FolloerReixews(rev) {
    reviews = rev;
  }

  @override
  _FolloerReixewsState createState() => _FolloerReixewsState();
}

class _FolloerReixewsState extends State<FolloerReixews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reviews'),
        backgroundColor: Color(0xFFF2945E),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.reviews,
          ),
        ),
      ),
    );
  }
}
