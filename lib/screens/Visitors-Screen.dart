import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/globals.dart' as globals;

class VisitorsScreen extends StatefulWidget {
  @override
  _VisitorsScreenState createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        centerTitle: true,
        title: Text('Visitors'),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('places')
                .doc('${globals.currentPlace}')
                .collection('visitors')
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
                return Center(
                  child: Text(
                    "No one visited this place",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                );
              }

              final data = snapshot.data.docs;
              List<TourGuideBigCard> TourGuides = [];
              for (var tourGuide in data) {
                TourGuides.add(
                  TourGuideBigCard(
                    tourGuide.get('userName'),
                  ),
                );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: TourGuides,
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

class TourGuideBigCard extends StatelessWidget {
  String tname;
  TourGuideBigCard(String name) {
    tname = name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
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
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.person_outline_outlined,
                    size: 50,
                    color: Colors.white54,
                  ),
                  radius: 40,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  tname,
                  style: TextStyle(fontFamily: 'RocknRollOne', fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}