import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athar/providers/FollowerProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/providers/auth.dart';

class FollowerCard extends StatefulWidget {
  String name;
  Image avatar;
  bool isFollow;
  String type;
  var dataBase;

  FollowerCard(String name, bool isFollow) {
    this.name = name;
    this.isFollow = isFollow;
    if (Authentication.TourGuide) type = 'tourGuides';
    type = 'normalUsers';
    dataBase = FirebaseFirestore.instance
        .collection('users')
        .doc(type)
        .collection(type)
        .doc("${Authentication.currntUsername}")
        .collection('Followers')
        .get();
  }

  @override
  State<FollowerCard> createState() => _FollowerCardState();
}

class _FollowerCardState extends State<FollowerCard> {
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
                              .collection('Followers')
                              .doc(widget.name)
                              .delete();
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
                              .collection('Followers')
                              .doc(widget.name)
                              .set({});
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
