import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/Widgets/PlaceCard2.dart';
import 'SubscribedPlaces-Screen.dart';
import '../MyReviews-Screen.dart';
import '../MyFavoritePlaces.dart';
import '../Followers-Screen.dart';
import '../Settings-Screen.dart';
import 'package:athar/screens/Language-Screen.dart';
import 'package:athar/Widgets/FollowerCard.dart';
import '../Followings-Screen.dart';
import 'Plans-Screen.dart';

class TourGuideProfileScreen extends StatefulWidget {
  @override
  _TourGuideProfileScreenState createState() => _TourGuideProfileScreenState();
}

class _TourGuideProfileScreenState extends State<TourGuideProfileScreen> {
  final auth = Authentication();
  final dataBase = FirebaseFirestore.instance;
  List<PlaceCard2> PlacesList2 = [];
  List<FollowerCard> followers = [];
  List<FollowerCard> followings = [];
  String contactInfo = '';

  List<String> accountPrivacy = ['Public', "Private"];
  List<String> languages = ['English', "Arabic"];
  String currentLanguage = "English";
  String currentPrivacy = "Public";

  bool isActive;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        centerTitle: true,
        title: Text('Profile'),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/logOut.png',
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Sign out'),
                      content: Text('Are you sure about signing out?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No')),
                        TextButton(
                            onPressed: () {
                              auth.signOut(context);
                            },
                            child: Text('Yes')),
                      ],
                    ));
          },
        ),
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
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc('tourGuides')
                        .collection('tourGuides')
                        .doc(Authentication.currntUsername)
                        .snapshots(),
                    builder: (BuildContext,
                        AsyncSnapshot<DocumentSnapshot<Object>> s) {
                      if (s.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 120,
                        );
                      } else {
                        if (s.data.get('header') == "") {
                          return Image.asset(
                            'assets/images/userDefultHeader.png',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Image.network(
                            "${s.data.get('header')}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }
                      }
                    }),
                Positioned(
                  bottom: -50,
                  child: Stack(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc('tourGuides')
                            .collection('tourGuides')
                            .doc(Authentication.currntUsername)
                            .snapshots(),
                        builder: (BuildContext,
                            AsyncSnapshot<DocumentSnapshot<Object>> s) {
                          if (s.connectionState == ConnectionState.waiting) {
                            return CircleAvatar(
                              radius: 50,
                            );
                          }
                          if (s.data.get('avatar') == "") {
                            return CircleAvatar(
                              child: Image.asset(
                                'assets/images/userDefultAvatar.png',
                                width: 70,
                                color: Colors.white,
                              ),
                              radius: 50,
                              backgroundColor: Colors.grey,
                            );
                          }
                          return CircleAvatar(
                            backgroundImage: NetworkImage(
                              s.data.get('avatar'),
                            ),
                            radius: 50,
                            backgroundColor: Colors.grey,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/TourGuideIcon.png',
                              color: Colors.white,
                            ),
                          ),
                          radius: 15,
                          backgroundColor: Color(0xFFF2945E),
                        ),
                      ),
                    ],
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
                child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc('tourGuides')
                        .collection('tourGuides')
                        .doc(Authentication.currntUsername)
                        .snapshots(),
                    builder: (BuildContext,
                        AsyncSnapshot<DocumentSnapshot<Object>> s) {
                      if (s.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      contactInfo = s.data.get('ContactInfo');
                      return Text(
                        s.data.get('name'),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      );
                    }),
              ),
              subtitle:
                  Center(child: Text('@${Authentication.currntUsername}')),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc('tourGuides')
                      .collection('tourGuides')
                      .doc(Authentication.currntUsername)
                      .snapshots(),
                  builder: (BuildContext,
                      AsyncSnapshot<DocumentSnapshot<Object>> s) {
                    if (s.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    return Text(
                      s.data.get('ContactInfo'),
                      style: TextStyle(fontSize: 14),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
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
                            .doc('tourGuides')
                            .collection('tourGuides')
                            .doc("${Authentication.currntUsername}")
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
                            .doc('tourGuides')
                            .collection('tourGuides')
                            .doc("${Authentication.currntUsername}")
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
            Divider(),
            Container(
              height: 220,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Subscribed Places',
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
                                      SubscribedPlaces(PlacesList2)),
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
                    child: FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc('tourGuides')
                          .collection('tourGuides')
                          .doc(Authentication.currntUsername)
                          .collection('SubscribedPlaces')
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
                              padding: const EdgeInsets.only(top: 60),
                              child: CircularProgressIndicator(
                                color: Color(0xFFF2945E),
                              ),
                            ),
                          );
                        }
                        if (snapshot.requireData.docs.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Text(
                                "You did not visit any place",
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
                          children: (PlacesList2.length > 3)
                              ? PlacesList2.sublist(0, 3)
                              : PlacesList2,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'My Reviews',
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
                              builder: (context) => MyReviewsScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: (Authentication.TourGuide)
                                  ? FirebaseFirestore.instance
                                      .collection('users')
                                      .doc('tourGuides')
                                      .collection('tourGuides')
                                      .doc("${Authentication.currntUsername}")
                                      .collection('reviews')
                                      .snapshots()
                                  : FirebaseFirestore.instance
                                      .collection('users')
                                      .doc('normalUsers')
                                      .collection('normalUsers')
                                      .doc("${Authentication.currntUsername}")
                                      .collection('reviews')
                                      .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('');
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
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'My Favorite Places ',
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
                              builder: (context) => MyFavoritePlaces()),
                        );
                      },
                      child: Row(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: (Authentication.TourGuide)
                                  ? FirebaseFirestore.instance
                                      .collection('users')
                                      .doc('tourGuides')
                                      .collection('tourGuides')
                                      .doc("${Authentication.currntUsername}")
                                      .collection('FavoritePlaces')
                                      .snapshots()
                                  : FirebaseFirestore.instance
                                      .collection('users')
                                      .doc('normalUsers')
                                      .collection('normalUsers')
                                      .doc("${Authentication.currntUsername}")
                                      .collection('FavoritePlaces')
                                      .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('');
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
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Membership',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'RocknRollOne',
                        fontSize: 16,
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc('tourGuides')
                            .collection('tourGuides')
                            .doc("${Authentication.currntUsername}")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text('');
                          }
                          DateTime expiryDate =
                              DateTime.parse(snapshot.data.get('expiryDate'));
                          DateTime now = new DateTime.now();
                          DateTime date =
                              new DateTime(now.year, now.month, now.day);
                          if (expiryDate.isBefore(date)) {
                            isActive = false;
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlansScreen()),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Expired",
                                    style: TextStyle(fontSize: 16),
                                  ),
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
                            );
                          } else {
                            isActive = true;
                            return Text(
                              '${expiryDate.year}/${expiryDate.month}/${expiryDate.day}',
                              style: TextStyle(fontSize: 16),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Language',
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
                              builder: (context) => LanguageScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'English',
                            style: TextStyle(fontSize: 16),
                          ),
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
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
