import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;

class PlansScreen extends StatefulWidget {
  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int selectedPlan = 1;
  int amount = 50;
  var url = 'https://us-central1-athar-654db.cloudfunctions.net/paypalPayment';

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
                          selectedPlan = 1;
                          amount = 10;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: (selectedPlan == 1)
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
                          selectedPlan = 2;
                          amount = 30;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: (selectedPlan == 2)
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
                          selectedPlan = 3;
                          amount = 60;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: (selectedPlan == 3)
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
