import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:geolocator/geolocator.dart';
import '/globals.dart' as globals;
import 'package:athar/screens/User_Screens/User-Place-Screen.dart';
import 'package:athar/screens/TourGuide_Screens/TourGuide-Place-Screen.dart';
import 'package:athar/providers/auth.dart';

class PlaceCard extends StatelessWidget {
  var loc = Geolocator();
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
  PlaceCard(name, PlaceTotalRate, Location, aboutThePlace, openingHours,
      tekPrice, webSite, List images, latitude, longitude) {
    PlaceName = name;
    this.PlaceTotalRate = PlaceTotalRate;
    this.Location = Location;
    this.aboutThePlace = aboutThePlace;
    this.openingHours = openingHours;
    this.tekPrice = tekPrice;
    this.webSite = webSite;

    this.images = images;
    placeLatitude = latitude;
    placeLongitude = longitude;
    dis = (Geolocator.distanceBetween(globals.latitude, globals.longitude,
            placeLatitude, placeLongitude)) /
        1000;
  }

  Widget build(BuildContext context) {
    dis = (Geolocator.distanceBetween(globals.latitude, globals.longitude,
            placeLatitude, placeLongitude)) /
        1000;
    return Card(
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
                      child: LikeButton(
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.redAccent : Colors.grey,
                            size: 25,
                          );
                        },
                        likeCountPadding: EdgeInsets.all(0),
                        size: 25,
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
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
                      PlaceName,
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
                                "${dis.toStringAsFixed(1)}km",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'RocknRollOne',
                                  fontSize: 12,
                                ),
                              ),
                        Row(
                          children: [
                            Text(
                              PlaceTotalRate.toString(),
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
                        ),
                      ],
                    )
                  ],
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
    );
  }
}
