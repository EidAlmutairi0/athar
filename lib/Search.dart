import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'screens/TourGuide_Screens/TourGuide-Place-Screen.dart';
import 'screens/User_Screens/User-Place-Screen.dart';
import 'providers/auth.dart';
import '/globals.dart' as globals;

class Search extends SearchDelegate<String> {
  final statelist = [
    'Andaman and Nicobar Islands',
    '   Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh ',
    'Chhattisgarh',
    'Dadra and Nagar Havel',
    'Daman and Diu',
    'Delhi',
    'Goa',
    'Gujrat',
    'Haryana',
    'Himachal Pradesh',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Sikkim',
    'Meghalya',
    'Mizoram',
  ];
  final recentlist = ['Modingar', 'Ghaziabad', 'Merrut', 'Hapur', 'Delhi'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // action for app bar
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      height: 150.0,
      child: Card(
        color: Colors.red,
        shape: StadiumBorder(),
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    return StreamBuilder<QuerySnapshot>(
      stream: (query != "" && query != null)
          ? FirebaseFirestore.instance
              .collection('places')
              .where('searchKey', arrayContains: query.toLowerCase())
              .snapshots()
          : FirebaseFirestore.instance.collection("places").snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return InkWell(
                    onTap: () {
                      globals.currentPlace = data.get('name');
                      print(globals.currentPlace);
                      if (Authentication.TourGuide) {
                        globals.currentPlace = data.get('name');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TourguidePlaceScreen(
                                    data.get('name'),
                                    data.get('PlaceTotalRate'),
                                    data.get('Location'),
                                    data.get('aboutThePlace'),
                                    data.get('openingHours'),
                                    data.get('tekPrice'),
                                    data.get('webSite'),
                                    data.get("images"),
                                    data.get('latitude'),
                                    data.get('longitude'))));
                      } else {
                        globals.currentPlace = data.get('name');

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPlaceScreen(
                                    data.get('name'),
                                    data.get('PlaceTotalRate'),
                                    data.get('Location'),
                                    data.get('aboutThePlace'),
                                    data.get('openingHours'),
                                    data.get('tekPrice'),
                                    data.get('webSite'),
                                    data.get("images"),
                                    data.get('latitude'),
                                    data.get('longitude'))));
                      }
                    },
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            data['images'][0],
                            width: 150,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            data['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
