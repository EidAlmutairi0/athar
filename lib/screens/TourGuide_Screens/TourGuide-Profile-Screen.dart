import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/Widgets/PlaceCard2.dart';
import 'SubscribedPlaces-Screen.dart';

class TourGuideProfileScreen extends StatefulWidget {
  @override
  _TourGuideProfileScreenState createState() => _TourGuideProfileScreenState();
}

class _TourGuideProfileScreenState extends State<TourGuideProfileScreen> {
  final auth = Authentication();
  final dataBase = FirebaseFirestore.instance;
  List<PlaceCard2> PlacesList2 = [];

  List<String> accountPrivacy = ['Public', "Private"];
  List<String> languages = ['English', "Arabic"];
  String currentLanguage = "English";
  String currentPrivacy = "Public";

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
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
                Image.asset(
                  'assets/images/userDefultHeader.png',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: -50,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/eid.jpg'),
                        backgroundColor: Colors.grey,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 20,
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
                child: Text(
                  Authentication.currntUsername,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
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
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      Text(
                        '89',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
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
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      Text(
                        '27',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
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
                          children: (PlacesList2.length > 4)
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
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.grey,
                      size: 16,
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
                    'My Favorite Places ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'RocknRollOne',
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                  DropdownButton(
                    alignment: AlignmentDirectional.center,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: 2,
                    ),
                    items: languages
                        .map((String item) => DropdownMenuItem<String>(
                            child: Text(item), value: item))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        currentLanguage = value;
                      });
                    },
                    value: currentLanguage,
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                  DropdownButton(
                    alignment: AlignmentDirectional.center,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: 2,
                    ),
                    items: accountPrivacy
                        .map((String item) => DropdownMenuItem<String>(
                            child: Text(item), value: item))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        currentPrivacy = value;
                      });
                    },
                    value: currentPrivacy,
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
