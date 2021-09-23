import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/Widgets/PlaceCard.dart';
import '/Search.dart';

class TourGuideHomeScreen extends StatefulWidget {
  @override
  State<TourGuideHomeScreen> createState() => _TourGuideHomeScreenState();
}

class _TourGuideHomeScreenState extends State<TourGuideHomeScreen> {
  final auth = Authentication();

  var palces;

  void initState() {
    palces = FirebaseFirestore.instance.collection('places').snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: Search());
          },
        ),
        title: Text("TourGuide"),
        centerTitle: true,
        backgroundColor: Color(0xFFF2945E),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 50),
              child: StreamBuilder<QuerySnapshot>(
                stream: palces,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFF2945E),
                      ),
                    );
                  }
                  final data = snapshot.data.docs;
                  List<PlaceCard> PlacesList = [];
                  for (var plac in data) {
                    PlacesList.add(PlaceCard(
                      plac.get('name'),
                      plac.get('PlaceTotalRate'),
                      plac.get('Location'),
                      plac.get('aboutThePlace'),
                      plac.get('openingHours'),
                      plac.get('tekPrice'),
                      plac.get('webSite'),
                      plac.get('visiters'),
                      plac.get('tourGuides'),
                      plac.get("images"),
                    ));
                  }
                  bool done = false;
                  return Column(
                    children: PlacesList,
                  );
                },
              )),
        ),
      ),
    );
  }
}
