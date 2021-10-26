import 'package:flutter/material.dart';
import '/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../providers/auth.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:intl/intl.dart';

class WriteReviewsScreen extends StatefulWidget {
  @override
  State<WriteReviewsScreen> createState() => _WriteReviewsScreenState();
}

class _WriteReviewsScreenState extends State<WriteReviewsScreen> {
  double rating = 0.5;
  String review = '';
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Cancel?'),
                content: Text('Are you sure about canceling the review?'),
                actions: [
                  FlatButton(
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFF2945E),
        centerTitle: true,
        title: Text('${globals.currentPlace}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person_outline_outlined,
                      size: 35,
                      color: Colors.white54,
                    ),
                    radius: 30,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${Authentication.currntUsername}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RocknRollOne'),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SmoothStarRating(
                  allowHalfRating: true,
                  onRated: (v) {
                    setState(() {
                      rating = v;
                    });
                  },
                  starCount: 5,
                  rating: rating,
                  size: 50,
                  color: Colors.yellow.shade700,
                  borderColor: Colors.yellow.shade700,
                  spacing: 0.0),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 150,
                child: TextField(
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF2945E), width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Write a review',
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                  onSubmitted: (val) {
                    setState(() {
                      review = val;
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      review = val;
                    });
                  },
                ),
              ),
              Container(
                width: 280,
                height: 50,
                child: RaisedButton(
                  color: Color(0xFFF2945E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: () {
                    var id;

                    if (Authentication.TourGuide) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc('tourGuides')
                          .collection('tourGuides')
                          .doc("${Authentication.currntUsername}")
                          .collection('reviews')
                          .add({
                        'PlaceName': globals.currentPlace,
                        'review': review,
                        'rate': rating,
                        'Date': formatted,
                      }).then((value) {
                        id = value.id;
                        FirebaseFirestore.instance
                            .collection('places')
                            .doc('${globals.currentPlace}')
                            .get()
                            .then((value) {
                          var numOfRatings = value.get('numOfRatings');
                          var PlaceTotalRate = value.get('PlaceTotalRate');
                          if (numOfRatings != 0) {
                            FirebaseFirestore.instance
                                .collection('places')
                                .doc('${globals.currentPlace}')
                                .update({
                              'PlaceTotalRate':
                                  ((PlaceTotalRate * (numOfRatings)) + rating) /
                                      (numOfRatings + 1),
                            }).whenComplete(() {
                              FirebaseFirestore.instance
                                  .collection('places')
                                  .doc('${globals.currentPlace}')
                                  .update({
                                'numOfRatings': FieldValue.increment(1),
                              });

                              FirebaseFirestore.instance
                                  .collection('places')
                                  .doc('${globals.currentPlace}')
                                  .collection('reviews')
                                  .add({
                                'username': Authentication.currntUsername,
                                'review': review,
                                'rate': rating,
                                'Date': formatted,
                                'id': id,
                              }).whenComplete(() {
                                CoolAlert.show(
                                  barrierDismissible: false,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Your review was posted successfully!",
                                );
                              });
                            });
                          } else {
                            FirebaseFirestore.instance
                                .collection('places')
                                .doc('${globals.currentPlace}')
                                .update({
                              'numOfRatings': FieldValue.increment(1),
                              'PlaceTotalRate': rating
                            }).whenComplete(() {
                              FirebaseFirestore.instance
                                  .collection('places')
                                  .doc('${globals.currentPlace}')
                                  .collection('reviews')
                                  .add({
                                'username': Authentication.currntUsername,
                                'review': review,
                                'rate': rating,
                                'Date': formatted,
                                'id': id,
                              }).whenComplete(() {
                                CoolAlert.show(
                                  barrierDismissible: false,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Your review was posted successfully!",
                                );
                              });
                            });
                          }
                        });
                      });
                    } else {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc('normalUsers')
                          .collection('normalUsers')
                          .doc("${Authentication.currntUsername}")
                          .collection('reviews')
                          .add({
                        'PlaceName': globals.currentPlace,
                        'review': review,
                        'rate': rating,
                        'Date': formatted,
                      }).then((value) {
                        id = value.id;
                        FirebaseFirestore.instance
                            .collection('places')
                            .doc('${globals.currentPlace}')
                            .get()
                            .then((value) {
                          var numOfRatings = value.get('numOfRatings');
                          var PlaceTotalRate = value.get('PlaceTotalRate');
                          if (numOfRatings != 0) {
                            FirebaseFirestore.instance
                                .collection('places')
                                .doc('${globals.currentPlace}')
                                .update({
                              'PlaceTotalRate':
                                  ((PlaceTotalRate * (numOfRatings)) + rating) /
                                      (numOfRatings + 1),
                            }).whenComplete(() {
                              FirebaseFirestore.instance
                                  .collection('places')
                                  .doc('${globals.currentPlace}')
                                  .update({
                                'numOfRatings': FieldValue.increment(1),
                              });

                              FirebaseFirestore.instance
                                  .collection('places')
                                  .doc('${globals.currentPlace}')
                                  .collection('reviews')
                                  .add({
                                'username': Authentication.currntUsername,
                                'review': review,
                                'rate': rating,
                                'Date': formatted,
                                'id': id,
                              }).whenComplete(() {
                                CoolAlert.show(
                                  barrierDismissible: false,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Your review was posted successfully!",
                                );
                              });
                            });
                          } else {
                            FirebaseFirestore.instance
                                .collection('places')
                                .doc('${globals.currentPlace}')
                                .update({
                              'numOfRatings': FieldValue.increment(1),
                              'PlaceTotalRate': rating
                            }).whenComplete(() {
                              FirebaseFirestore.instance
                                  .collection('places')
                                  .doc('${globals.currentPlace}')
                                  .collection('reviews')
                                  .add({
                                'username': Authentication.currntUsername,
                                'review': review,
                                'rate': rating,
                                'Date': formatted,
                                'id': id,
                              }).whenComplete(() {
                                CoolAlert.show(
                                  barrierDismissible: false,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Your review was posted successfully!",
                                );
                              });
                            });
                          }
                        });
                      });
                    }
                  },
                  child: Center(
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.white, fontSize: 18),
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
