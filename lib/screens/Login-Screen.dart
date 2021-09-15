import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/providers/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var dataBase = FirebaseFirestore.instance;
  var auth = Authentication();
  String email;
  String password;
  bool validEmail = false;
  bool isTourGuide = false;

  bool validPassword = false;
  bool showCircularProgressIndicator = false;
  bool showCircularProgressIndicator2 = false;

  final _formKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

  FocusNode myFocusNode = new FocusNode();
  final double fontSize = 34;

  void _saveRestForm() {
    final isValid = _formKey.currentState.validate();
    _formKey.currentState.save();
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    _formKey.currentState.save();
  }

  Future<void> showRestDialog(BuildContext context) async {
    String ResstEmail;
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Password reset"),
            content: Form(
              key: _resetFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "Once you press send you will receive an email with the password reset link"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 280,
                    child: TextFormField(
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
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.black54,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black54)),
                      onChanged: (val) {
                        setState(() {
                          ResstEmail = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please enter an email.";
                        } else if (!EmailValidator.validate(val)) {
                          return "Please enter a valid email.";
                        }
                        setState(() {
                          ResstEmail = val;
                        });
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back")),
              TextButton(
                  onPressed: () async {
                    if (_resetFormKey.currentState.validate()) {
                      await auth.sendResetEmail(ResstEmail);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Send"))
            ],
          );
        });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/login_logo.png'),
                        width: 300,
                      ),
                      Container(
                        height: 100,
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hey,',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: fontSize,
                                fontFamily: 'Oxygen',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Login Now.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: fontSize,
                                fontFamily: 'Oxygen',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 280,
                        child: TextFormField(
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
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black54,
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black54)),
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter an email.";
                            } else if (!EmailValidator.validate(val)) {
                              return "Please enter a valid email.";
                            }
                            setState(() {
                              email = val;
                              validEmail = true;
                            });
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 280,
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFF2945E), width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                color: Colors.black54,
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black54)),
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter a password.";
                            }
                            setState(() {
                              password = val;
                              validPassword = true;
                            });
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          height: 30,
                          width: 250,
                          child: Row(
                            children: [
                              Text(
                                'Forget your password?/',
                                style: TextStyle(color: Colors.black54),
                              ),
                              TextButton(
                                onPressed: () async {
                                  showRestDialog(context);
                                },
                                child: Text(
                                  'Reset',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 250,
                        child: Row(
                          children: [
                            Text(
                              "Don't have an account?/",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'SignUpScreen');
                              },
                              child: Text(
                                'Create one',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      showCircularProgressIndicator
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFF2945E),
                              ),
                            )
                          : new Container(
                              width: 280,
                              height: 50,
                              child: RaisedButton(
                                color: Color(0xFFF2945E),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    showCircularProgressIndicator = true;
                                    if (await auth.signIn(
                                            email, password, context) ==
                                        "Logged in") {
                                      setState(() {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            "UserHomeScreen",
                                            (r) => false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: Duration(milliseconds: 700),
                                          backgroundColor: Colors.green,
                                          content:
                                              Text('Logged in successfully'),
                                        ));
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: Duration(milliseconds: 700),
                                        backgroundColor: Colors.redAccent,
                                        content:
                                            Text('Wrong Email or password'),
                                      ));
                                    }
                                    setState(() {
                                      showCircularProgressIndicator = false;
                                    });
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Oxygen",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      showCircularProgressIndicator2
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFF2945E),
                              ),
                            )
                          : new Container(
                              width: 280,
                              height: 50,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0))),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    showCircularProgressIndicator2 = true;
                                    if (await auth.tourGuidesignIn(
                                            email, password, context) ==
                                        "Logged in") {
                                      setState(() {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            "TourGuideHomeScreen",
                                            (r) => false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: Duration(milliseconds: 700),
                                          backgroundColor: Colors.green,
                                          content:
                                              Text('Logged in successfully'),
                                        ));
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: Duration(milliseconds: 700),
                                        backgroundColor: Colors.redAccent,
                                        content:
                                            Text('Wrong Email or password'),
                                      ));
                                    }
                                    setState(() {
                                      showCircularProgressIndicator2 = false;
                                    });
                                  }
                                },
                                child: Text(
                                  "Login as a Tour guide",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Oxygen",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
