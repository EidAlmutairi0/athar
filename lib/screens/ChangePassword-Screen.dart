import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/providers/auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var dataBase = FirebaseFirestore.instance;

  Future<bool> reLogin() async {
    try {
      var a = await _firebaseAuth.currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: Email, password: currentPassword));

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> upDateEmail(String val, ctx) async {
    try {
      var x = await _firebaseAuth.currentUser.updatePassword(val);
      return true;
    } catch (e) {
      Scaffold.of(ctx)
          .showSnackBar(SnackBar(content: Text('Your new password is weak')));
      setState(() {
        isPressed = false;
      });
      return false;
    }
  }

  validate(String val, ctx) async {
    bool a = await reLogin();
    // ignore: unrelated_type_equality_checks
    if (a) {
      bool x = await upDateEmail(val, ctx);
      if (x) {
        if (Authentication.TourGuide) {
          dataBase
              .collection('users')
              .doc('tourGuides')
              .collection('tourGuides')
              .doc(Authentication.currntUsername)
              .update({'password': val});
        } else {
          dataBase
              .collection('users')
              .doc('normalUsers')
              .collection('normalUsers')
              .doc(Authentication.currntUsername)
              .update({'password': val});
        }
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(
            'Email has been change successfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ));
        setState(() {
          isPressed = false;
        });
      }
    } else {
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text('Wrong password')));
      setState(() {
        isPressed = false;
      });
    }
  }

  String Email;
  String newPassword;
  String currentPassword;
  bool isPressed = false;
  bool logingError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                Email = val;
                              });
                              print(Email);
                            },
                            onSaved: (val) {
                              setState(() {
                                Email = val;
                              });
                              print(Email);
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFF2945E), width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelStyle: TextStyle(color: Colors.black54)),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter an email.";
                              }
                              if (_firebaseAuth.currentUser.email != val) {
                                return "Wrong current email";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                currentPassword = val;
                              });
                            },
                            onSaved: (val) {
                              setState(() {
                                currentPassword = val;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFF2945E), width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelStyle: TextStyle(color: Colors.black54)),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter a password";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                newPassword = val;
                              });
                              print(newPassword);
                            },
                            onSaved: (val) {
                              setState(() {
                                newPassword = val;
                              });
                              print(newPassword);
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFF2945E), width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelStyle: TextStyle(color: Colors.black54)),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter a password";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  height: 60,
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF2945E),
                    ),
                    onPressed: (isPressed)
                        ? null
                        : () {
                            print(Authentication.currntUsername);
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            setState(() {
                              isPressed = true;
                            });
                            validate(newPassword, context);
                          },
                    child: (isPressed)
                        ? CircularProgressIndicator()
                        : Text(
                            'Change',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
