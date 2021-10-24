import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:line_icons/line_icons.dart';
import 'package:athar/Widgets/TourGuidCard.dart';
import '/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/screens/Tourguides-Screen.dart';
import 'package:athar/screens/Visitors-Screen.dart';
import '../Place-Reviews-Screen.dart';
import 'package:geolocator/geolocator.dart';
import '../LocationService.dart';
import 'package:athar/providers/auth.dart';

class TourguidePlaceScreen extends StatefulWidget {
  var loc = Geolocator();

  String PlaceName;
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

  TourguidePlaceScreen(
    name,
    PlaceTotalRate,
    Location,
    aboutThePlace,
    openingHours,
    tekPrice,
    webSite,
    List images,
    placeLatitude,
    placeLongitude,
  ) {
    PlaceName = name;
    this.PlaceTotalRate = PlaceTotalRate;
    this.Location = Location;
    this.aboutThePlace = aboutThePlace;
    this.openingHours = openingHours;
    this.tekPrice = tekPrice;
    this.webSite = webSite;
    this.images = images;
    this.placeLatitude = placeLatitude;
    this.placeLongitude = placeLongitude;
    dis = (Geolocator.distanceBetween(globals.latitude, globals.longitude,
            placeLatitude, placeLongitude)) /
        1000;
  }

  @override
  State<TourguidePlaceScreen> createState() => _TourguidePlaceScreenState();
}

class _TourguidePlaceScreenState extends State<TourguidePlaceScreen>
    with TickerProviderStateMixin {
  bool check;

  TabController _controller;
  Image VRimage;
  String previewImageUrl =
      'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=$GOOGLE_API_KEY';

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    _getLocation();
    super.initState();
  }

  Future<String> _getLocation() async {
    final staticMAPImage = await LocationService.generateLocationPreviewImage(
        widget.PlaceName, widget.placeLatitude, widget.placeLongitude);
    setState(() {
      previewImageUrl = staticMAPImage;
    });
  }

  List<Widget> returnImages(images) {
    List<Widget> imagesList = [];
    for (var image in images) {
      imagesList.add(Container(
        height: 200,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ));
    }
    return imagesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  child: CarouselSlider(
                    items: returnImages(widget.images),
                    options: CarouselOptions(
                      aspectRatio: 1.5,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 5.0), //(x,y)
                                  blurRadius: 5,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                              child: IconButton(
                            color: Color(0xFFF2945E),
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25, left: 25, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.PlaceName,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'RocknRollOne',
                              fontSize: 20,
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
                                        fontSize: 14,
                                      ),
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              (widget.PlaceTotalRate != 0.1)
                                  ? Row(
                                      children: [
                                        Text(
                                          widget.PlaceTotalRate.toString(),
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
                    Column(
                      children: [
                        Divider(
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Container(
                            child: Text(
                              widget.aboutThePlace,
                              style: TextStyle(fontFamily: 'RocknRollOne'),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                child: Icon(
                                  LineIcons.clock,
                                  color: Color(0xFFF2945E),
                                ),
                              ),
                              Container(
                                width: 200,
                                margin: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Text(
                                  widget.openingHours,
                                  style: TextStyle(fontFamily: 'RocknRollOne'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                child: Icon(
                                  LineIcons.alternateTicket,
                                  color: Color(0xFFF2945E),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Text(
                                  widget.tekPrice,
                                  style: TextStyle(fontFamily: 'RocknRollOne'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                child: Icon(
                                  LineIcons.mousePointer,
                                  color: Color(0xFFF2945E),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Container(
                                  width: 200,
                                  child: (widget.webSite == '-')
                                      ? Text(
                                          widget.webSite,
                                          style: TextStyle(
                                              fontFamily: 'RocknRollOne'),
                                        )
                                      : TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(EdgeInsets.all(0)),
                                          ),
                                          child: Text(
                                            widget.webSite,
                                            style: TextStyle(
                                                fontFamily: 'RocknRollOne'),
                                          ),
                                          onPressed: () {
                                            launch(widget.webSite);
                                          },
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xFFF2945E),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Container(
                                  width: 200,
                                  child: (widget.Location == '-')
                                      ? Text(
                                          widget.Location,
                                          style: TextStyle(
                                              fontFamily: 'RocknRollOne'),
                                        )
                                      : TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(EdgeInsets.all(0)),
                                          ),
                                          child: Image.network(previewImageUrl),
                                          onPressed: () {
                                            launch(widget.Location);
                                          },
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Reviews',
                                  style: TextStyle(
                                    fontFamily: 'RocknRollOne',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFF2945E),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlaceReviewsScreen()));
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Visited By',
                                  style: TextStyle(
                                    fontFamily: 'RocknRollOne',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFF2945E),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VisitorsScreen()));
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Container(
                          height: 160,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tour Guides',
                                    style: TextStyle(
                                      fontFamily: 'RocknRollOne',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFFF2945E),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TourGuidesScreen()));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'See All',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: Colors.grey,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('places')
                                    .doc('${globals.currentPlace}')
                                    .collection('Tour Guides')
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
                                          "There is no tour guides for this place",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  final data = snapshot.data.docs;
                                  List<TourGuideCard> TourGuides = [];
                                  for (var tourGuide in data) {
                                    TourGuides.add(
                                      TourGuideCard(
                                        tourGuide.get('userName'),
                                      ),
                                    );
                                  }

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: TourGuides,
                                    ),
                                  );
                                  return Center(
                                    child: Text('There is no places'),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('places')
                                    .doc('${globals.currentPlace}')
                                    .collection('Tour Guides')
                                    .doc('${Authentication.currntUsername}')
                                    .get()
                                    .then((value) {
                                  if (value.exists) {
                                    check = true;
                                    print('exists');
                                    print('${Authentication.currntUsername}');
                                    return check;
                                  } else {
                                    check = false;
                                    print(
                                        '${Authentication.currntUsername} + 1');
                                    print('not exists');
                                    return check;
                                  }
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.data == true) {
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(25),
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('places')
                                              .doc('${globals.currentPlace}')
                                              .collection('Tour Guides')
                                              .doc(
                                                  '${Authentication.currntUsername}')
                                              .delete();
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc('tourGuides')
                                              .collection('tourGuides')
                                              .doc(
                                                  Authentication.currntUsername)
                                              .collection('SubscribedPlaces')
                                              .doc('${globals.currentPlace}')
                                              .delete();
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black45,
                                                  offset:
                                                      Offset(0, 5.0), //(x,y)
                                                  blurRadius: 7,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          width: 130,
                                          height: 130,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30,
                                                    right: 30,
                                                    top: 15,
                                                    bottom: 15),
                                                child: Container(
                                                    child: Image.asset(
                                                  "assets/images/checkIn.png",
                                                  color: Color(0xFFF2945E),
                                                )),
                                              ),
                                              Text(
                                                'Subscribed',
                                                style: TextStyle(
                                                  color: Color(0xFFF2945E),
                                                  fontFamily: 'RocknRollOne',
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(25),
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('places')
                                              .doc('${globals.currentPlace}')
                                              .collection('Tour Guides')
                                              .doc(
                                                  '${Authentication.currntUsername}')
                                              .set({
                                            'userName':
                                                Authentication.currntUsername
                                          });
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc('tourGuides')
                                              .collection('tourGuides')
                                              .doc(
                                                  Authentication.currntUsername)
                                              .collection('SubscribedPlaces')
                                              .doc('${globals.currentPlace}')
                                              .set({
                                            'PlaceName': globals.currentPlace,
                                            'image': widget.images,
                                          });
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black45,
                                                  offset:
                                                      Offset(0, 5.0), //(x,y)
                                                  blurRadius: 7,
                                                ),
                                              ],
                                              color: Color(0xFFF2945E),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          width: 130,
                                          height: 130,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30,
                                                    right: 30,
                                                    top: 15,
                                                    bottom: 15),
                                                child: Container(
                                                    child: Image.asset(
                                                  "assets/images/checkIn.png",
                                                  color: Colors.white,
                                                )),
                                              ),
                                              Text(
                                                'Subscribe',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'RocknRollOne',
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black45,
                                              offset: Offset(0, 5.0), //(x,y)
                                              blurRadius: 7,
                                            ),
                                          ],
                                          color: Color(0xFFF2945E),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      width: 130,
                                      height: 130,
                                      child: Padding(
                                        padding: const EdgeInsets.all(40),
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(0, 5.0), //(x,y)
                                        blurRadius: 7,
                                      ),
                                    ],
                                    color: Color(0xFFF2945E),
                                    borderRadius: BorderRadius.circular(25)),
                                width: 130,
                                height: 130,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          top: 15,
                                          bottom: 15),
                                      child: Icon(
                                        LineIcons.cardboardVr,
                                        size: 65,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Virtual Tour',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'RocknRollOne',
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   child: GridView.count(
            //     crossAxisCount: 1,
            //     mainAxisSpacing: 2,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
