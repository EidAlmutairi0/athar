import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                  return Card(
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
                  );
                },
              );
      },
    );
  }
}
