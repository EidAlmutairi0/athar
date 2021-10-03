import 'package:flutter/material.dart';

class TourGuideCard extends StatelessWidget {
  String tourGuideName;

  TourGuideCard(String name) {
    tourGuideName = name;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.person_outline_outlined,
              size: 50,
              color: Colors.white54,
            ),
            radius: 40,
            backgroundColor: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            tourGuideName,
            style: TextStyle(fontFamily: 'RocknRollOne', fontSize: 16),
          )
        ],
      ),
    );
  }
}
