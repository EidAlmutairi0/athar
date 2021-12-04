import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;
import 'package:athar/providers/auth.dart';
import 'package:intl/intl.dart';

class PlansScreen extends StatefulWidget {
  @override
  _PlansScreenState createState() => _PlansScreenState();
}

List places = [];

class _PlansScreenState extends State<PlansScreen> {
  getSubscribedPlaces() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('tourGuides')
        .collection('tourGuides')
        .doc(Authentication.currntUsername)
        .collection('SubscribedPlaces')
        .get()
        .then((value) {
      places = value.docs.map((doc) => doc.id).toList();
    });
  }

  updateSubscribedPlaces(List places, String date) async {
    for (var place in places) {
      await FirebaseFirestore.instance
          .collection('places')
          .doc(place)
          .collection('Tour Guides')
          .doc(Authentication.currntUsername)
          .update({'expiryDate': date});
    }
  }

  int selectedIndex = 1;
  int selectedPlan = 1;
  int amount = 10;
  var url = 'https://us-central1-athar-654db.cloudfunctions.net/paypalPayment';

  @override
  void initState() {
    getSubscribedPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Text(
                    'Choose Your Plan',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                color: Color(0xFFF5F7FB),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                          selectedPlan = 1;
                          amount = 10;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: (selectedIndex == 1)
                                ? Border.all(
                                    width: 2,
                                    color: Color(0xFFF2945E),
                                  )
                                : Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: 80,
                          width: MediaQuery.of(context).size.width - 60,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'One Month',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$10",
                                  style: TextStyle(
                                    color: Color(0xFFF2945E),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                          selectedPlan = 3;
                          amount = 30;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: (selectedIndex == 2)
                                ? Border.all(
                                    width: 2,
                                    color: Color(0xFFF2945E),
                                  )
                                : Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: 80,
                          width: MediaQuery.of(context).size.width - 60,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Three Months',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$30",
                                  style: TextStyle(
                                    color: Color(0xFFF2945E),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 3;
                          selectedPlan = 12;
                          amount = 60;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: (selectedIndex == 3)
                                ? Border.all(
                                    width: 2,
                                    color: Color(0xFFF2945E),
                                  )
                                : Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: 80,
                          width: MediaQuery.of(context).size.width - 60,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'One Year',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$60",
                                  style: TextStyle(
                                    color: Color(0xFFF2945E),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF2945E),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () async {
                            var request = BraintreeDropInRequest(
                              tokenizationKey:
                                  "sandbox_38dhwgr9_jtbybby5fv5w33hx",
                              collectDeviceData: true,
                              paypalRequest: BraintreePayPalRequest(
                                amount: amount.toString(),
                                displayName: 'Athar',
                              ),
                            );

                            BraintreeDropInResult result =
                                await BraintreeDropIn.start(request);
                            if (result != null) {
                              print(result.paymentMethodNonce.description);
                              print(result.paymentMethodNonce.nonce);

                              final http.Response response = await http.post(
                                  Uri.tryParse(
                                      '$url?payment_method_nonce=${result.paymentMethodNonce}&device_data=${result.deviceData}'));
                              final payResult = jsonDecode(response.body);
                              if (payResult['result'] == 'success') {
                                var date = DateTime.now();
                                if (selectedPlan != 12) {
                                  var newDate = DateTime(date.year,
                                      date.month + selectedPlan, date.day);

                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc('tourGuides')
                                      .collection('tourGuides')
                                      .doc(Authentication.currntUsername)
                                      .update({
                                    "expiryDate":
                                        DateFormat("yyyy-MM-dd").format(newDate)
                                  });
                                  Navigator.pop(context);
                                  updateSubscribedPlaces(places,
                                      DateFormat("yyyy-MM-dd").format(newDate));
                                } else {
                                  var newDate = DateTime(
                                      date.year + 1, date.month, date.day);
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc('tourGuides')
                                      .collection('tourGuides')
                                      .doc(Authentication.currntUsername)
                                      .update({
                                    "expiryDate":
                                        DateFormat("yyyy-MM-dd").format(newDate)
                                  });
                                  Navigator.pop(context);
                                  updateSubscribedPlaces(places,
                                      DateFormat("yyyy-MM-dd").format(newDate));
                                }
                                print('payment done');
                              }
                            }
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 90,
                            child: Center(
                                child: Text(
                              'Pay',
                              style: TextStyle(fontSize: 24),
                            )),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
