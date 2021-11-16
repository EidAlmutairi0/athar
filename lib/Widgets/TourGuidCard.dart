import 'package:athar/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/screens/TourGuide_Screens/TourGuideFollower-Screen.dart';

class TourGuideCard extends StatefulWidget {
  String tourGuideName;
  String myType;

  TourGuideCard(String name) {
    tourGuideName = name;
    if (Authentication.TourGuide == true) {
      myType = 'tourGuides';
    } else {
      myType = 'normalUsers';
    }
  }

  @override
  State<TourGuideCard> createState() => _TourGuideCardState();
}

class _TourGuideCardState extends State<TourGuideCard> {
  bool isFollowe = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc('tourGuides')
                  .collection('tourGuides')
                  .doc(widget.tourGuideName)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(),
                          Text(
                            '@${widget.tourGuideName}',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  );
                }
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.myType)
                    .collection(widget.myType)
                    .doc(Authentication.currntUsername)
                    .collection('Followings')
                    .doc(widget.tourGuideName)
                    .get()
                    .then((value) => {
                          if (value.exists) {isFollowe = true}
                        });
                return InkWell(
                  onTap: (Authentication.currntUsername == widget.tourGuideName)
                      ? null
                      : () {
                          var avatar = '';
                          var header = '';
                          if (snapshot.data.get('avatar') != '') {
                            setState(() {
                              avatar = snapshot.data.get('avatar');
                            });
                          }
                          if (snapshot.data.get('header') != '') {
                            setState(() {
                              header = snapshot.data.get('header');
                            });
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TourGuideFollowerScreen(
                                      widget.tourGuideName,
                                      snapshot.data.get('name'),
                                      avatar,
                                      header,
                                      isFollowe,
                                    )),
                          );
                        },
                  child: Column(
                    children: [
                      (snapshot.data.get('avatar') == '')
                          ? CircleAvatar(
                              child: Icon(
                                Icons.person_outline_outlined,
                                size: 50,
                                color: Colors.white54,
                              ),
                              radius: 30,
                              backgroundColor: Colors.grey,
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data.get('avatar')),
                              radius: 30,
                              backgroundColor: Colors.grey,
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data.get('name'),
                            style: TextStyle(
                                fontFamily: 'RocknRollOne', fontSize: 16),
                          ),
                          Text(
                            '@${widget.tourGuideName}',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
