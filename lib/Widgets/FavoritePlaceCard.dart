import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:geolocator/geolocator.dart';
import '/globals.dart' as globals;
import 'package:athar/screens/User_Screens/User-Place-Screen.dart';
import 'package:athar/screens/TourGuide_Screens/TourGuide-Place-Screen.dart';
import 'package:athar/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritePlaceCard extends StatefulWidget {
  String PlaceName;
  String image;
  double PlaceTotalRate;
  String Location;
  String aboutThePlace;
  String openingHours;
  String tekPrice;
  String webSite;
  List images;
  double placeLatitude;
  double placeLongitude;
  double dis;
  bool isLiked;
  @override
  FavoritePlaceCard(name, image) {
    PlaceName = name;
    this.image = image;
  }

  @override
  _FavoritePlaceCardState createState() => _FavoritePlaceCardState();
}

class _FavoritePlaceCardState extends State<FavoritePlaceCard> {
  var loc = Geolocator();

  PlaceLiked(bool isLike) {
    if (isLike) {
      if (Authentication.TourGuide == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .set({
          'PlaceName': widget.PlaceName,
          'image': widget.images[0],
        });
        return true;
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .set({
          'PlaceName': widget.PlaceName,
          'image': widget.images[0],
        });
        return true;
      }
    } else {
      if (Authentication.TourGuide == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .delete();

        return false;
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .delete();

        return false;
      }
    }
  }

  Future<bool> onLikeButtonTapped(bool isLike) async {
    if (!isLike) {
      if (Authentication.TourGuide == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .set({
          'PlaceName': widget.PlaceName,
          'image': widget.images[0],
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .set({
          'PlaceName': widget.PlaceName,
          'image': widget.images[0],
        });
      }
    } else {
      if (Authentication.TourGuide == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .delete();
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .delete();
      }
    }
    return !isLike;
  }

  Future<bool> onLikeButtonTapped2(bool isLike) async {
    if (isLike) {
      if (Authentication.TourGuide == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .set({
          'PlaceName': widget.PlaceName,
          'image': widget.images[0],
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .set({
          'PlaceName': widget.PlaceName,
          'image': widget.images[0],
        });
      }
    } else {
      if (Authentication.TourGuide == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('tourGuides')
            .collection('tourGuides')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .delete();
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(Authentication.currntUsername)
            .collection('FavoritePlaces')
            .doc(widget.PlaceName)
            .delete();
      }
    }
    return !isLike;
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('places')
        .doc(widget.PlaceName)
        .get()
        .then((value) {
      widget.PlaceTotalRate = value.get('PlaceTotalRate');
      widget.Location = value.get('Location');
      widget.aboutThePlace = value.get('aboutThePlace');
      widget.openingHours = value.get('openingHours');
      widget.tekPrice = value.get('tekPrice');
      widget.webSite = value.get('webSite');
      widget.images = value.get('images');
      widget.placeLatitude = value.get('latitude');
      widget.placeLongitude = value.get('longitude');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      margin: EdgeInsets.fromLTRB(0.0, 0, 0.0, 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          globals.currentPlace = widget.PlaceName;
          print(globals.currentPlace);
          if (Authentication.TourGuide)
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TourguidePlaceScreen(
                        widget.PlaceName,
                        this.widget.PlaceTotalRate,
                        this.widget.Location,
                        this.widget.aboutThePlace,
                        this.widget.openingHours,
                        this.widget.tekPrice,
                        this.widget.webSite,
                        this.widget.images,
                        widget.placeLatitude,
                        widget.placeLongitude,
                      )),
            );
          else
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserPlaceScreen(
                        widget.PlaceName,
                        this.widget.PlaceTotalRate,
                        this.widget.Location,
                        this.widget.aboutThePlace,
                        this.widget.openingHours,
                        this.widget.tekPrice,
                        this.widget.webSite,
                        this.widget.images,
                        widget.placeLatitude,
                        widget.placeLongitude,
                      )),
            );
        },
        child: Container(
          height: 230,
          width: 330,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GridTile(
              header: GridTileBar(
                leading: Container(),
                title: Container(),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 10),
                  child: Container(
                    width: 40,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 5.0), //(x,y)
                            blurRadius: 7,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: (widget.isLiked)
                          ? LikeButton(
                              onTap: onLikeButtonTapped2,
                              likeBuilder: (isLiked) {
                                return Icon(
                                  Icons.favorite,
                                  color:
                                      !isLiked ? Colors.redAccent : Colors.grey,
                                  size: 25,
                                );
                              },
                              likeCountPadding: EdgeInsets.all(0),
                              size: 25,
                              circleColor: CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                            )
                          : LikeButton(
                              onTap: onLikeButtonTapped,
                              likeBuilder: (isLiked) {
                                return Icon(
                                  Icons.favorite,
                                  color:
                                      isLiked ? Colors.redAccent : Colors.grey,
                                  size: 25,
                                );
                              },
                              likeCountPadding: EdgeInsets.all(0),
                              size: 25,
                              circleColor: CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.PlaceName,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'RocknRollOne',
                        fontSize: 18,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (globals.longitude == 5 && globals.latitude == 5)
                            ? Container()
                            : Text(
                                "${widget.dis.toStringAsFixed(1)}km",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'RocknRollOne',
                                  fontSize: 12,
                                ),
                              ),
                        (widget.PlaceTotalRate != 0.1)
                            ? Row(
                                children: [
                                  Text(
                                    widget.PlaceTotalRate.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'RocknRollOne',
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Image.asset(
                                    "assets/images/star.png",
                                    width: 15,
                                    height: 15,
                                  )
                                ],
                              )
                            : Container()
                      ],
                    )
                  ],
                ),
              ),
              child: Image.network(
                widget.images[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
