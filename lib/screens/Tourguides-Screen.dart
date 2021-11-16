import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/globals.dart' as globals;
import 'package:athar/providers/auth.dart';
import 'package:athar/screens/TourGuide_Screens/TourGuideFollower-Screen.dart';

class TourGuidesScreen extends StatefulWidget {
  @override
  _TourGuidesScreenState createState() => _TourGuidesScreenState();
}

class _TourGuidesScreenState extends State<TourGuidesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        centerTitle: true,
        title: Text('Tour Guides'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('places')
                  .doc('${globals.currentPlace}')
                  .collection('Tour Guides')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong'),
                  );
                  return Center(
                    child: Text('Something went wrong'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator(
                        color: Color(0xFFF2945E),
                      ),
                    ),
                  );
                }
                if (snapshot.requireData.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        "There is no tour guides for this place",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }

                final data = snapshot.data.docs;
                List<TourGuideBigCard> TourGuides = [];
                for (var tourGuide in data) {
                  TourGuides.add(
                    TourGuideBigCard(
                      tourGuide.get('userName'),
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: TourGuides,
                  ),
                );
                return Center(
                  child: Text('There is no places'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TourGuideBigCard extends StatelessWidget {
  String tname;
  String myType;
  bool isFollowe = false;

  TourGuideBigCard(String name) {
    tname = name;

    if (Authentication.TourGuide == true) {
      myType = 'tourGuides';
    } else {
      myType = 'normalUsers';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(tname)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFF2945E)),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 5.0), //(x,y)
                    blurRadius: 7,
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width - 50,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: [
                        Container(),
                        Text(
                          '@$tname',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          FirebaseFirestore.instance
              .collection('users')
              .doc(myType)
              .collection(myType)
              .doc(Authentication.currntUsername)
              .collection('Followings')
              .doc(tname)
              .get()
              .then((value) => {
                    if (value.exists) {isFollowe = true}
                  });
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFF2945E)),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 5.0), //(x,y)
                  blurRadius: 7,
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width - 50,
            child: InkWell(
              onTap: (Authentication.currntUsername == tname)
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TourGuideFollowerScreen(
                                  tname,
                                  snapshot.data.get('name'),
                                  snapshot.data.get('avatar'),
                                  snapshot.data.get('header'),
                                  isFollowe,
                                )),
                      );
                    },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data.get('name'),
                          style: TextStyle(
                              fontFamily: 'RocknRollOne', fontSize: 16),
                        ),
                        Text(
                          '@$tname',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
