import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/providers/auth.dart';
import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool checked = false;
  bool touch = false;
  List<Review> reviews = [];
  List<User> followers = [];
  List<User> followings = [];
  List places = [];
  String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool user = Authentication.TourGuide;

  Future<bool> reLogin() async {
    try {
      var a = await _firebaseAuth.currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser.email, password: password));

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  getUserData() async {
    if (user) {
      await database
          .collection('users')
          .doc('tourGuides')
          .collection('tourGuides')
          .doc(Authentication.currntUsername)
          .collection('reviews')
          .get()
          .then((value) {
        print(value.docs.first.id);
        reviews = value.docs
            .map((doc) => Review(doc.get('PlaceName'), doc.id))
            .toList();
      });
      await database
          .collection('users')
          .doc('tourGuides')
          .collection('tourGuides')
          .doc(Authentication.currntUsername)
          .collection('SubscribedPlaces')
          .get()
          .then((value) {
        places = value.docs.map((doc) => doc.id).toList();
      });
      await database
          .collection('users')
          .doc('tourGuides')
          .collection('tourGuides')
          .doc(Authentication.currntUsername)
          .collection('Followers')
          .get()
          .then((value) {
        followers = value.docs
            .map((doc) => User(doc.id, doc.get('isTourGuide')))
            .toList();
      });
      await database
          .collection('users')
          .doc('tourGuides')
          .collection('tourGuides')
          .doc(Authentication.currntUsername)
          .collection('Followings')
          .get()
          .then((value) {
        followings = value.docs
            .map((doc) => User(doc.id, doc.get('isTourGuide')))
            .toList();
      });
    } else {
      await database
          .collection('users')
          .doc('normalUsers')
          .collection('normalUsers')
          .doc(Authentication.currntUsername)
          .collection('reviews')
          .get()
          .then((value) {
        reviews = value.docs
            .map((doc) => Review(doc.get('PlaceName'), doc.id))
            .toList();
      });
      await database
          .collection('users')
          .doc('normalUsers')
          .collection('normalUsers')
          .doc(Authentication.currntUsername)
          .collection('VisitedPlaces')
          .get()
          .then((value) {
        places = value.docs.map((doc) => doc.id).toList();
      });
      await database
          .collection('users')
          .doc('normalUsers')
          .collection('normalUsers')
          .doc(Authentication.currntUsername)
          .collection('Followers')
          .get()
          .then((value) {
        followers = value.docs
            .map((doc) => User(doc.id, doc.get('isTourGuide')))
            .toList();
      });
      await database
          .collection('users')
          .doc('normalUsers')
          .collection('normalUsers')
          .doc(Authentication.currntUsername)
          .collection('Followings')
          .get()
          .then((value) {
        followings = value.docs
            .map((doc) => User(doc.id, doc.get('isTourGuide')))
            .toList();
      });
    }
  }

  Future<bool> deleteData() async {
    //Delete visited places
    if (user) {
      for (var a in places) {
        await database
            .collection('places')
            .doc(a)
            .collection('Tour Guides')
            .doc(Authentication.currntUsername)
            .delete();
      }
    } else {
      for (var a in places) {
        await database
            .collection('places')
            .doc(a)
            .collection('visitors')
            .doc(Authentication.currntUsername)
            .delete();
      }
    }

    for (var a in reviews) {
      await database
          .collection('places')
          .doc(a.placeNmae)
          .collection('reviews')
          .where('id', isEqualTo: a.reviewID)
          .get()
          .then((value) {
        database
            .collection('places')
            .doc(a.placeNmae)
            .collection('reviews')
            .doc(value.docs.first.id)
            .delete();
      });
    }
    for (var a in followings) {
      await database
          .collection('users')
          .doc(a.userType)
          .collection(a.userType)
          .doc(a.userName)
          .collection('Followers')
          .doc(Authentication.currntUsername)
          .delete();
    }
    for (var a in followers) {
      await database
          .collection('users')
          .doc(a.userType)
          .collection(a.userType)
          .doc(a.userName)
          .collection('Followings')
          .doc(Authentication.currntUsername)
          .delete();
    }

    if (user) {
      database
          .collection('users')
          .doc('tourGuides')
          .collection('tourGuides')
          .doc(Authentication.currntUsername)
          .delete();
    } else {
      database
          .collection('users')
          .doc('normalUsers')
          .collection('normalUsers')
          .doc(Authentication.currntUsername)
          .delete();
    }
    return true;
  }

  @override
  void initState() {
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        title: Text('Delete Account'),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return AbsorbPointer(
          absorbing: touch,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Are you sure about deleting your account?',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        'Note that deleting your account will delete your username, comments, reviews and all related data',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 200,
                              child: TextFormField(
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                onSaved: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2945E), width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelStyle:
                                        TextStyle(color: Colors.black54)),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter a password";
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                              value: checked,
                              onChanged: (val) {
                                setState(() {
                                  checked = val;
                                });
                              }),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                                "I'm aware of all results this action will cause and completely sure about my decision"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: 140,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF2945E),
                          ),
                          onPressed: (checked &&
                                  _formKey.currentState.validate())
                              ? () async {
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  setState(() {
                                    touch = true;
                                  });
                                  bool a = await reLogin();
                                  if (a) {
                                    deleteData().whenComplete(() {
                                      print('worked');
                                      _firebaseAuth.currentUser
                                          .delete()
                                          .whenComplete(() {
                                        Authentication().signOut(context);
                                      });

                                      setState(() {
                                        touch = false;
                                      });
                                    });
                                  } else {
                                    print('did not worked');
                                    setState(() {
                                      touch = false;
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Wrong password')));
                                    setState(() {
                                      touch = false;
                                    });
                                  }
                                }
                              : null,
                          child: (touch)
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Confirm',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class Review {
  String placeNmae;
  String reviewID;

  Review(String a, String p) {
    placeNmae = a;
    reviewID = p;
  }
}

class User {
  String userName;
  String userType;

  User(String a, bool p) {
    userName = a;
    if (p)
      userType = 'tourGuides';
    else
      userType = 'normalUsers';
  }
}
