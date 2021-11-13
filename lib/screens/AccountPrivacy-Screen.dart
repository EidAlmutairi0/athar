import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/providers/auth.dart';

class AccountPrivacyScreen extends StatefulWidget {
  String option;
  int value;
  String userType;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AccountPrivacyScreen(String option) {
    this.option = option;
    if (option == 'Public') {
      value = 1;
    } else {
      value = 2;
    }
    if (Authentication.TourGuide)
      userType = 'tourGuides';
    else {
      userType = 'normalUsers';
    }
  }
  @override
  _AccountPrivacyScreenState createState() => _AccountPrivacyScreenState();
}

class _AccountPrivacyScreenState extends State<AccountPrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        title: Text('Account Privacy'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: ListTile(
                      title: Text('Public'),
                      subtitle: Text(
                          'This option means that your places and reviews will appear to other users '),
                    ),
                  ),
                  Radio(
                      value: 1,
                      groupValue: widget.value,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
                        widget.firestore
                            .collection('users')
                            .doc(widget.userType)
                            .collection(widget.userType)
                            .doc(Authentication.currntUsername)
                            .update({'Privacy': 'Public'});
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: ListTile(
                      title: Text('Private'),
                      subtitle: Text(
                          'This option means that your places and reviews will not appear to other users '),
                    ),
                  ),
                  Radio(
                      value: 2,
                      groupValue: widget.value,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
                        widget.firestore
                            .collection('users')
                            .doc(widget.userType)
                            .collection(widget.userType)
                            .doc(Authentication.currntUsername)
                            .update({'Privacy': 'Private'});
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
