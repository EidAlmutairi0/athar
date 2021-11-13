import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/Widgets/PlaceCard2.dart';
import 'VisitedPlaces-Screen.dart';
import '../MyReviews-Screen.dart';
import '../MyFavoritePlaces.dart';
import '../Followers-Screen.dart';
import 'package:athar/Widgets/FollowerCard.dart';
import '../Followings-Screen.dart';
import '../Settings-Screen.dart';
import 'package:athar/screens/AccountPrivacy-Screen.dart';
import 'package:athar/screens/Language-Screen.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  final auth = Authentication();
  final dataBase = FirebaseFirestore.instance;
  List<PlaceCard2> PlacesList2 = [];
  List<FollowerCard> followers = [];
  List<FollowerCard> followings = [];
  String option;
  List<String> languages = ['English', "Arabic"];
  String currentLanguage = "English";
  String currentPrivacy = "Public";

  @override
  @override
  Widget build(BuildContext context) {
    List<FollowerCard> followers = [];

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
                        .doc('normalUsers')
                        .collection('normalUsers')
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
                      return Image.asset(
                        'assets/images/userDefultHeader.png',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }),
                Positioned(
                  bottom: -50,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc('normalUsers')
                        .collection('normalUsers')
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
                        .doc('normalUsers')
                        .collection('normalUsers')
                        .doc(Authentication.currntUsername)
                        .snapshots(),
                    builder: (BuildContext,
                        AsyncSnapshot<DocumentSnapshot<Object>> s) {
                      if (s.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
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
                            .doc('normalUsers')
                            .collection('normalUsers')
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
                            .doc(Authentication.currntUsername)
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
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Account Privacy',
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
                              builder: (context) =>
                                  AccountPrivacyScreen(option)),
                        );
                      },
                      child: Row(
                        children: [
                          StreamBuilder<DocumentSnapshot>(
                              stream: (Authentication.TourGuide)
                                  ? FirebaseFirestore.instance
                                      .collection('users')
                                      .doc('tourGuides')
                                      .collection('tourGuides')
                                      .doc("${Authentication.currntUsername}")
                                      .snapshots()
                                  : FirebaseFirestore.instance
                                      .collection('users')
                                      .doc('normalUsers')
                                      .collection('normalUsers')
                                      .doc("${Authentication.currntUsername}")
                                      .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('');
                                }

                                option = snapshot.data.get('Privacy');

                                return Text(
                                  snapshot.data.get('Privacy'),
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
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
