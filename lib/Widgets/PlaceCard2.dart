import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '/globals.dart' as globals;
import 'package:athar/screens/User_Screens/User-Place-Screen.dart';
import 'package:athar/screens/TourGuide_Screens/TourGuide-Place-Screen.dart';
import 'package:athar/providers/auth.dart';

class PlaceCard2 extends StatelessWidget {
  var loc = Geolocator();
  var database;
  // ignore: non_constant_identifier_names
  String PlaceName;
  double PlaceTotalRate;
  String Location;
  String aboutThePlace;
  String openingHours;
  String tekPrice;
  String webSite;

  List images;
  Image VRimage;
  double placeLatitude;
  double placeLongitude;
  double dis;

  @override
  PlaceCard2(name, image) {
    PlaceName = name;
    this.images = image;
    database = FirebaseFirestore.instance
        .collection('places')
        .doc('$PlaceName')
        .get()
        .then((value) {
      this.PlaceTotalRate = value.get('PlaceTotalRate');
      this.Location = value.get('Location');
      this.aboutThePlace = value.get('aboutThePlace');
      this.openingHours = value.get('openingHours');
      this.tekPrice = value.get('tekPrice');
      this.webSite = value.get('webSite');
      placeLatitude = value.get('latitude');
      placeLongitude = value.get('longitude');
    }).whenComplete(() => dis = (Geolocator.distanceBetween(globals.latitude,
                globals.longitude, placeLatitude, placeLongitude)) /
            1000);
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7, left: 7),
      child: Card(
        elevation: 9,
        margin: EdgeInsets.fromLTRB(0.0, 0, 0.0, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            globals.currentPlace = PlaceName;
            print(globals.currentPlace);
            if (Authentication.TourGuide)
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TourguidePlaceScreen(
                          PlaceName,
                          this.PlaceTotalRate,
                          this.Location,
                          this.aboutThePlace,
                          this.openingHours,
                          this.tekPrice,
                          this.webSite,
                          this.images,
                          placeLatitude,
                          placeLongitude,
                        )),
              );
            else
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserPlaceScreen(
                          PlaceName,
                          this.PlaceTotalRate,
                          this.Location,
                          this.aboutThePlace,
                          this.openingHours,
                          this.tekPrice,
                          this.webSite,
                          this.images,
                          placeLatitude,
                          placeLongitude,
                        )),
              );
          },
          child: Container(
            height: 140,
            width: 190,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GridTile(
                header: GridTileBar(),
                footer: GridTileBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    PlaceName,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RocknRollOne',
                      fontSize: 14,
                    ),
                  ),
                ),
                child: Image.network(
                  images[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
