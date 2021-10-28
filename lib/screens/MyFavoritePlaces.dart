import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:athar/Widgets/FavoritePlaceCard.dart';
import '../providers/auth.dart';

class MyFavoritePlaces extends StatelessWidget {
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
              List<FavoritePlaceCard> reviews = [];
              for (var FavPlace in data) {
                reviews.add(
                  FavoritePlaceCard(
                    FavPlace.get('PlaceName'),
                    FavPlace.get('image'),
                  ),
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
