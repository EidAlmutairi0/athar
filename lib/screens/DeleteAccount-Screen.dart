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
  List reviews = [];
  List places = [];

  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool user = Authentication.TourGuide;

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
        reviews = value.docs.toList();
      });
      await database
          .collection('users')
          .doc('tourGuides')
          .collection('tourGuides')
          .doc(Authentication.currntUsername)
          .collection('SubscribedPlaces')
          .get()
          .then((value) {
        print(value.docs.first.id);

        places = value.docs.toList();
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
        print(value.docs.first.id);

        reviews = value.docs.toList();
      });
      await database
          .collection('users')
          .doc('normalUsers')
          .collection('normalUsers')
          .doc(Authentication.currntUsername)
          .collection('VisitedPlaces')
          .get()
          .then((value) {
        print(value.docs.first.id);

        places = value.docs.toList();
      });
    }
  }

  @override
  void initState() {
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: touch,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF2945E),
          title: Text('Delete Account'),
          centerTitle: true,
        ),
        body: Padding(
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
                    onPressed: (checked)
                        ? () {
                            print(reviews.first);
                            print(places[0]);

                            setState(() {
                              touch = true;
                            });
                            Timer(Duration(seconds: 2), () {
                              setState(() {
                                touch = false;
                              });
                            });
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
    );
  }
}
