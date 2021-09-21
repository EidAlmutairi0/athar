import 'package:flutter/material.dart';
import '/providers/auth.dart';
import 'package:like_button/like_button.dart';
import '/Search.dart';

class TourGuideHomeScreen extends StatelessWidget {
  final auth = Authentication();

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 9,
                  margin: EdgeInsets.fromLTRB(0.0, 40, 0.0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
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
                            padding:
                                const EdgeInsets.only(right: 10.0, top: 10),
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
                                      color: isLiked
                                          ? Colors.redAccent
                                          : Colors.grey,
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
                                "Diriyah",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'RocknRollOne',
                                  fontSize: 18,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '3.0km',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'RocknRollOne',
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '4.0',
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
                          'https://cdn.sabq.org/uploads/media-cache/resize_800_relative/uploads/material-file/5dd5988f544a6959fd8b459c/5dd598dccb513.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 9,
                  margin: EdgeInsets.fromLTRB(0.0, 40, 0.0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
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
                            padding:
                                const EdgeInsets.only(right: 10.0, top: 10),
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
                                      color: isLiked
                                          ? Colors.redAccent
                                          : Colors.grey,
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
                                "Qasr Al Hokm",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'RocknRollOne',
                                  fontSize: 18,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '7.0km',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'RocknRollOne',
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '3.5',
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
                          'https://www.rcrc.gov.sa/wp-content/uploads/2019/09/17.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 9,
                  margin: EdgeInsets.fromLTRB(0.0, 40, 0.0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    height: 220,
                    width: 330,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GridTile(
                        header: GridTileBar(
                          title: Container(),
                          trailing: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, top: 10),
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
                                      color: isLiked
                                          ? Colors.redAccent
                                          : Colors.grey,
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
                                "Al-Masmak Fortress",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'RocknRollOne',
                                  fontSize: 18,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '7.1km',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'RocknRollOne',
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '3.6',
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
                          'https://e3arabi.com/wp-content/uploads/2020/08/shutterstock_1437855551-780x470.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
