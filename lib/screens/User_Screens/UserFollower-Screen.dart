import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/Widgets/PlaceCard2.dart';
import '../MyReviews-Screen.dart';
import 'VisitedPlaces-Screen.dart';
import '../Followers-Screen.dart';
import 'package:athar/Widgets/FollowerCard.dart';
import '../Followings-Screen.dart';
import '../FollowerReviews-Screen.dart';

class UserFollowerScreen extends StatefulWidget {
  String username;
  String name;
  String userAvatar;
  String userHeader;

  UserFollowerScreen(
    String username,
    String name,
    String userAvatar,
    String userHeader,
  ) {
    this.username = username;
    this.name = name;
    this.userAvatar = userAvatar;
    this.userHeader = userHeader;
  }

  @override
  _UserFollowerScreenState createState() => _UserFollowerScreenState();
}

class _UserFollowerScreenState extends State<UserFollowerScreen> {
  final dataBase = FirebaseFirestore.instance;
  List<Review2> reviews = [];
  List<PlaceCard2> PlacesList2 = [];
  List<FollowerCard> followers = [];
  List<FollowerCard> followings = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                (widget.userHeader == "")
                    ? {
                        Image.asset(
                          'assets/images/userDefultHeader.png',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      }
                    : Image.network(
                        widget.userHeader,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                Positioned(
                  bottom: -50,
                  child: (widget.userAvatar == "")
                      ? {
                          CircleAvatar(
                            child: Image.asset(
                              'assets/images/userDefultAvatar.png',
                              width: 70,
                              color: Colors.white,
                            ),
                            radius: 50,
                            backgroundColor: Colors.grey,
                          ),
                        }
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.userAvatar,
                          ),
                          radius: 50,
                          backgroundColor: Colors.grey,
                        ),
                ),

                // Container(
                //   child: ,
                // )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            ListTile(
              title: Center(
                child: Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
              subtitle: Center(child: Text(widget.username)),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FollowersScreen(followers)),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc('normalUsers')
                            .collection('normalUsers')
                            .doc(widget.username)
                            .collection('Followers')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                            );
                          }
                          var fllo = snapshot.data.docs;
                          List<FollowerCard> ff = [];
                          for (var follor in fllo) {
                            var temp = followings.singleWhere(
                                (element) => element.name == follor.id,
                                orElse: () => null);

                            ff.add(FollowerCard(follor.id));
                          }
                          followers = ff;

                          return Text(
                            snapshot.data.size.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w700),
                          );
                        },
                      ),
                      Text(
                        'followers',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FollowingsScreen(followings)),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc('normalUsers')
                            .collection('normalUsers')
                            .doc(widget.username)
                            .collection('Followings')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                            );
                          }
                          var fllo = snapshot.data.docs;
                          List<FollowerCard> ff = [];

                          for (var follor in fllo) {
                            ff.add(FollowerCard(follor.id));
                          }
                          followings = ff;

                          return Text(
                            snapshot.data.size.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w700),
                          );
                        },
                      ),
                      Text(
                        'followings',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF2945E),
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    child: Center(
                        child: Text(
                      'Follow',
                      style: TextStyle(fontSize: 20),
                    )),
                  )),
            ),
            Divider(),
            Container(
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Visited Places',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'RocknRollOne',
                            fontSize: 16,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VisitedPlaces(PlacesList2)),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'See All',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: Colors.grey,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Center(
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc('normalUsers')
                            .collection('normalUsers')
                            .doc(widget.username)
                            .collection('VisitedPlaces')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Something went wrong'),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 60, left: 170),
                                child: CircularProgressIndicator(
                                  color: Color(0xFFF2945E),
                                ),
                              ),
                            );
                          }
                          if (snapshot.requireData.docs.isEmpty) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 60, left: 20),
                                child: Text(
                                  "This user did not visit any place",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }

                          final data = snapshot.data.docs;
                          for (var plac in data) {
                            PlacesList2.add(
                                PlaceCard2(plac.id, plac.get('image')));
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (PlacesList2.length > 4)
                                ? PlacesList2.sublist(0, 3)
                                : PlacesList2,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'RocknRollOne',
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FolloerReixews(reviews)),
                      );
                    },
                    child: Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc('normalUsers')
                                .collection('normalUsers')
                                .doc(widget.username)
                                .collection('reviews')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text('');
                              }
                              final data = snapshot.data.docs;
                              for (var review in data) {
                                reviews.add(
                                  Review2(
                                      review.get('PlaceName'),
                                      review.get('review'),
                                      review.get('rate'),
                                      review.get('Date'),
                                      review.id),
                                );
                              }
                              return Text(
                                snapshot.data.size.toString(),
                                style: TextStyle(fontSize: 16),
                              );
                            }),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
