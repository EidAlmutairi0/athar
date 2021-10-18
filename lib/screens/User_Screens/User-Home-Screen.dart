import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/providers/auth.dart';
import '/Search.dart';
import '/globals.dart' as globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/Widgets/PlaceCard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final auth = Authentication();
  @override
  String region = 'All';
  List<String> regionsList = ['All', 'Riyadh', 'Mecca', 'Eastern'];
  String sortBy = 'Distance';
  List<String> sortByList = ['Distance', 'Rating'];

  Future getPlaces() async {
    var dataBase =
        await FirebaseFirestore.instance.collection('places').get().then(
      (value) {
        for (int i = 0; i < value.docs.length; i++) {
          globals.places.add(
            Marker(
              markerId: MarkerId(value.docs[i].id),
              position: LatLng(
                value.docs[i].get('latitude'),
                value.docs[i].get('longitude'),
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                onTap: () {},
                title: value.docs[i].get('name'),
              ),
            ),
          );
        }
      },
    );
  }

  void initState() {
    getPlaces();
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
        title: Text("User"),
        centerTitle: true,
        backgroundColor: Color(0xFFF2945E),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40, top: 20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton(
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        decoration: BoxDecoration(color: Colors.black12),
                        height: 2,
                      ),
                      items: sortByList
                          .map((String item) => DropdownMenuItem<String>(
                              child: Text(item), value: item))
                          .toList(),
                      onChanged: (String value) {
                        setState(() {
                          sortBy = value;
                        });
                      },
                      value: sortBy,
                    ),
                    SizedBox(
                      width: 10,
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
                      items: regionsList
                          .map((String item) => DropdownMenuItem<String>(
                              child: Text(item), value: item))
                          .toList(),
                      onChanged: (String value) {
                        setState(() {
                          region = value;
                        });
                      },
                      value: region,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: (sortBy == "Distance")
                    ? StreamBuilder<QuerySnapshot>(
                        stream: (region == 'All')
                            ? FirebaseFirestore.instance
                                .collection('places')
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('places')
                                .where('region', isEqualTo: region)
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: CircularProgressIndicator(
                                  color: Color(0xFFF2945E),
                                ),
                              ),
                            );
                          }
                          if (snapshot.requireData.docs.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Center(
                                child: Text(
                                  "There is no places in this region",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }

                          final data = snapshot.data.docs;
                          List<PlaceCard> PlacesList = [];
                          for (var plac in data) {
                            PlacesList.add(
                              PlaceCard(
                                  plac.get('name'),
                                  plac.get('PlaceTotalRate'),
                                  plac.get('Location'),
                                  plac.get('aboutThePlace'),
                                  plac.get('openingHours'),
                                  plac.get('tekPrice'),
                                  plac.get('webSite'),
                                  plac.get("images"),
                                  plac.get('latitude'),
                                  plac.get('longitude')),
                            );
                          }
                          PlacesList.sort((a, b) => a.dis.compareTo(b.dis));
                          return Column(
                            children: PlacesList,
                          );
                          return Center(
                            child: Text('There is no places'),
                          );
                        },
                      )
                    : StreamBuilder<QuerySnapshot>(
                        stream: (region == 'All')
                            ? FirebaseFirestore.instance
                                .collection('places')
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('places')
                                .where('region', isEqualTo: region)
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: CircularProgressIndicator(
                                  color: Color(0xFFF2945E),
                                ),
                              ),
                            );
                          }
                          if (snapshot.requireData.docs.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Center(
                                child: Text(
                                  "There is no places in this region",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }

                          final data = snapshot.data.docs;
                          List<PlaceCard> PlacesList = [];
                          for (var plac in data) {
                            PlacesList.add(
                              PlaceCard(
                                  plac.get('name'),
                                  plac.get('PlaceTotalRate'),
                                  plac.get('Location'),
                                  plac.get('aboutThePlace'),
                                  plac.get('openingHours'),
                                  plac.get('tekPrice'),
                                  plac.get('webSite'),
                                  plac.get("images"),
                                  plac.get('latitude'),
                                  plac.get('longitude')),
                            );
                          }
                          PlacesList.sort((a, b) =>
                              a.PlaceTotalRate.compareTo(b.PlaceTotalRate));

                          return Column(
                            children: PlacesList.reversed.toList(),
                          );
                          return Center(
                            child: Text('There is no places'),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
