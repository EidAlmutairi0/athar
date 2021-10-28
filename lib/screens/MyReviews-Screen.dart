import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Write-Review-Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../providers/auth.dart';
import 'dart:async';
import '/globals.dart' as globals;

class MyReviewsScreen extends StatefulWidget {
  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        centerTitle: true,
        title: Text('My Reviews'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
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
                      "You have no reviews",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }

              final data = snapshot.data.docs;
              List<Review> reviews = [];
              for (var review in data) {
                reviews.add(
                  Review(review.get('PlaceName'), review.get('review'),
                      review.get('rate'), review.get('Date'), review.id),
                );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: reviews,
                ),
              );
              return Center(
                child: Text('There is no places'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Review extends StatelessWidget {
  String tname;
  String text;
  double rate;
  var date;
  var id;
  Review(String name, String text, double rate, var date, var id) {
    this.text = text;
    this.rate = rate;
    tname = name;
    this.date = date;
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tname,
                            style: TextStyle(
                                fontFamily: 'RocknRollOne', fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SmoothStarRating(
                              isReadOnly: true,
                              starCount: 5,
                              rating: rate,
                              size: 20,
                              color: Colors.yellow.shade700,
                              borderColor: Colors.yellow.shade700,
                              spacing: 0.0),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              var numOfRatings;
                              var totalRate;
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Delete the review"),
                                    content: Text(
                                        "Are you sure about deleting the review?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('No')),
                                      TextButton(
                                          onPressed: () {
                                            if (Authentication.TourGuide) {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc('tourGuides')
                                                  .collection('tourGuides')
                                                  .doc(
                                                      "${Authentication.currntUsername}")
                                                  .collection('reviews')
                                                  .doc(id)
                                                  .delete()
                                                  .whenComplete(() {
                                                Navigator.pop(context);
                                              });
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc('normalUsers')
                                                  .collection('normalUsers')
                                                  .doc(
                                                      "${Authentication.currntUsername}")
                                                  .collection('reviews')
                                                  .doc(id)
                                                  .delete()
                                                  .whenComplete(() {
                                                Navigator.pop(context);
                                              });
                                            }
                                            FirebaseFirestore.instance
                                                .collection('places')
                                                .doc('$tname')
                                                .get()
                                                .then((value) {
                                              if (value.get('numOfRatings') ==
                                                  1) {
                                                FirebaseFirestore.instance
                                                    .collection('places')
                                                    .doc('$tname')
                                                    .update({
                                                  'PlaceTotalRate': 0.1
                                                }).whenComplete(() {
                                                  FirebaseFirestore.instance
                                                      .collection('places')
                                                      .doc('$tname')
                                                      .update(
                                                          {'numOfRatings': 0});

                                                  FirebaseFirestore.instance
                                                      .collection('places')
                                                      .doc('$tname')
                                                      .collection('reviews')
                                                      .where("id",
                                                          isEqualTo: id)
                                                      .get()
                                                      .then((value) {
                                                    FirebaseFirestore.instance
                                                        .collection('places')
                                                        .doc('$tname')
                                                        .collection('reviews')
                                                        .doc(
                                                            value.docs.first.id)
                                                        .delete();
                                                  });
                                                });
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection('places')
                                                    .doc('$tname')
                                                    .get()
                                                    .then((value) {
                                                  numOfRatings =
                                                      value.get('numOfRatings');
                                                  totalRate = value
                                                      .get('PlaceTotalRate');
                                                }).then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('places')
                                                      .doc('$tname')
                                                      .update({
                                                    'numOfRatings':
                                                        numOfRatings - 1,
                                                    'PlaceTotalRate': ((totalRate *
                                                                numOfRatings) -
                                                            rate) /
                                                        (numOfRatings - 1),
                                                  }).whenComplete(() {
                                                    FirebaseFirestore.instance
                                                        .collection('places')
                                                        .doc('$tname')
                                                        .collection('reviews')
                                                        .where("id",
                                                            isEqualTo: id)
                                                        .get()
                                                        .then((value) {
                                                      FirebaseFirestore.instance
                                                          .collection('places')
                                                          .doc('$tname')
                                                          .collection('reviews')
                                                          .doc(value
                                                              .docs.first.id)
                                                          .delete();
                                                    });
                                                  });
                                                });
                                              }
                                            });
                                          },
                                          child: Text('Yes')),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.redAccent,
                              size: 20,
                            )),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          date,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(text),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
