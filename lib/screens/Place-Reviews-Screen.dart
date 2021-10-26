import 'package:flutter/material.dart';
import 'Write-Review-Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '/globals.dart' as globals;

class PlaceReviewsScreen extends StatefulWidget {
  @override
  State<PlaceReviewsScreen> createState() => _PlaceReviewsScreenState();
}

class _PlaceReviewsScreenState extends State<PlaceReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        centerTitle: true,
        title: Text('Reviews'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WriteReviewsScreen()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFFF2945E),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('places')
                .doc('${globals.currentPlace}')
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
                      "There is no reviews for this place",
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
                  Review(review.get('username'), review.get('review'),
                      review.get('rate'), review.get('Date')),
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
  Review(String name, String text, double rate, var date) {
    this.text = text;
    this.rate = rate;
    tname = name;
    this.date = date;
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.person_outline_outlined,
                          size: 30,
                          color: Colors.white54,
                        ),
                        radius: 25,
                        backgroundColor: Colors.grey,
                      ),
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
                  Expanded(
                    child: Container(
                      height: 50,
                      alignment: Alignment.bottomRight,
                      child: Text(
                        date,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
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
