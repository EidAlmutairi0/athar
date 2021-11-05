import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/providers/auth.dart';

class FollowerCard extends StatefulWidget {
  String name;
  Image avatar;
  bool isFollow;
  String type;
  bool userType;
  var dataBase;
  bool ist;

  FollowerCard(String name) {
    this.name = name;
    if (Authentication.TourGuide) {
      type = 'tourGuides';
      ist = true;
    } else {
      type = 'normalUsers';
      ist = false;
    }
    dataBase = FirebaseFirestore.instance
        .collection('users')
        .doc(type)
        .collection(type)
        .doc("${Authentication.currntUsername}")
        .collection('Followings')
        .get();
    FirebaseFirestore.instance
        .collection('users')
        .doc(type)
        .collection(type)
        .doc("${Authentication.currntUsername}")
        .collection('Followings')
        .doc(name)
        .get()
        .then((value) {
      if (value.exists)
        isFollow = true;
      else {
        isFollow = false;
      }
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc('tourGuides')
        .collection('tourGuides')
        .doc("$name")
        .get()
        .then((value) {
      if (value.exists)
        userType = true;
      else {
        userType = false;
      }
    });
  }

  @override
  State<FollowerCard> createState() => _FollowerCardState();
}

class _FollowerCardState extends State<FollowerCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFF2945E)),
            borderRadius: BorderRadius.circular(8),
          ),
          height: 80,
          width: MediaQuery.of(context).size.width - 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'RocknRollOne',
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: (widget.isFollow)
                    ? InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.type)
                              .collection(widget.type)
                              .doc("${Authentication.currntUsername}")
                              .collection('Followings')
                              .doc(widget.name)
                              .delete();
                          if (widget.userType) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc('tourGuides')
                                .collection('tourGuides')
                                .doc(widget.name)
                                .collection('Followers')
                                .doc("${Authentication.currntUsername}")
                                .delete();
                          } else {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc('normalUsers')
                                .collection('normalUsers')
                                .doc(widget.name)
                                .collection('Followers')
                                .doc("${Authentication.currntUsername}")
                                .delete();
                          }
                          setState(() {
                            widget.isFollow = false;
                          });
                          print(widget.isFollow);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xFFF2945E)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'following',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF2945E),
                              ),
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.type)
                              .collection(widget.type)
                              .doc("${Authentication.currntUsername}")
                              .collection('Followings')
                              .doc(widget.name)
                              .set({
                            'isTourGuide': widget.userType,
                          });
                          if (widget.userType) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc('tourGuides')
                                .collection('tourGuides')
                                .doc(widget.name)
                                .collection('Followers')
                                .doc("${Authentication.currntUsername}")
                                .set({
                              'isTourGuide': widget.ist,
                            });
                          } else {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc('normalUsers')
                                .collection('normalUsers')
                                .doc(widget.name)
                                .collection('Followers')
                                .doc("${Authentication.currntUsername}")
                                .set({
                              'isTourGuide': widget.ist,
                            });
                          }
                          setState(() {
                            widget.isFollow = true;
                          });
                          print(widget.isFollow);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2945E),
                            border: Border.all(
                              color: Color(0xFFF2945E),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'follow',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
