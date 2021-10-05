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
import 'package:athar/providers/auth.dart';

class TourguidePlaceScreen extends StatefulWidget {
  String PlaceName;
  double PlaceTotalRate;
  String Location;
  String aboutThePlace;
  String openingHours;
  String tekPrice;
  String webSite;
  List images;
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
    this.dis = dis;
  }

  @override
  State<TourguidePlaceScreen> createState() => _TourguidePlaceScreenState();
}

class _TourguidePlaceScreenState extends State<TourguidePlaceScreen>
    with TickerProviderStateMixin {
  Future check;
  Future chekSub() async {
    return await FirebaseFirestore.instance
        .collection('places')
        .doc('${globals.currentPlace}')
        .collection('Tour Guides')
        .doc('${Authentication.currntUsername}')
        .snapshots();
  }

  TabController _controller;
  Image VRimage;
  @override
  void initState() {
    check = chekSub();
    _controller = new TabController(length: 2, vsync: this);

    super.initState();
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
                                height: 100,
                                margin: const EdgeInsets.only(
                                  left: 70,
                                ),
                                child: FlatButton(
                                  child: Image.network(
                                      'https://i1.wp.com/www.cssscript.com/wp-content/uploads/2018/03/Simple-Location-Picker.png?fit=561%2C421&ssl=1'),
                                  onPressed: () {
                                    String url2 =
                                        'https://www.google.com/maps/place/%D9%82%D8%B5%D8%B1+%D8%A7%D9%84%D9%85%D8%B5%D9%85%D9%83%D8%8C+%D8%A7%D9%84%D8%A7%D9%85%D8%A7%D9%85+%D8%AA%D8%B1%D9%83%D9%8A+%D8%A8%D9%86+%D8%B9%D8%A8%D8%AF%D8%A7%D9%84%D9%84%D9%87+%D8%A8%D9%86+%D9%85%D8%AD%D9%85%D8%AF%D8%8C+%D8%A7%D9%84%D8%AF%D9%8A%D8%B1%D8%A9%D8%8C+%D8%A7%D9%84%D8%B1%D9%8A%D8%A7%D8%B6+12652%E2%80%AD/@24.6312147,46.7155691,17z/data=!3m1!4b1!4m5!3m4!1s0x3e2f05a68ffb79b3:0xaf1c06c11a421767!8m2!3d24.6312147!4d46.7133804';
                                    launch(url2);
                                  },
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
                                future: check,
                                builder: (context, snapshot) {
                                  // ignore: unrelated_type_equality_checks
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () {
                                        setState(() {});
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

                                        print(Authentication.currntUserEmail);
                                        print(Authentication.TourGuide);
                                        print(Authentication.currntUsername);
                                      },
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
                                  } else {
                                    return InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () {
                                        setState(() {});
                                        print(Authentication.currntUserEmail);
                                        print(Authentication.TourGuide);
                                        print(Authentication.currntUsername);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black45,
                                                offset: Offset(0, 5.0), //(x,y)
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
