import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:athar/providers/auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

enum userRule { user, tourGuide, admin }

class _SignUpScreenState extends State<SignUpScreen> {
  var auth = Authentication();

  String email;
  String username;
  String password;
  String passwordConf;
  bool isTourGuide = false;
  bool validUsername;
  bool validEmail = false;
  bool validPassword = false;
  bool showCircularProgressIndicator = false;

  void switcher(String mess) async {
    switch (mess) {
      case "user signed up":
        {
          setState(() {
            showCircularProgressIndicator = false;
          });
          setState(() {
            Navigator.pushNamedAndRemoveUntil(
                context, "UserHomeScreen", (r) => false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 700),
              backgroundColor: Colors.green,
              content: Text('Signed up successfully'),
            ));
          });
          break;
        }
      case "tourGuide signed up":
        {
          setState(() {
            setState(() {
              showCircularProgressIndicator = false;
            });
            Navigator.pushNamedAndRemoveUntil(
                context, "TourGuideHomeScreen", (r) => false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 700),
              backgroundColor: Colors.green,
              content: Text('Signed up successfully'),
            ));
          });
          break;
        }
      case "Username already exists":
        {
          setState(() {
            showCircularProgressIndicator = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(milliseconds: 700),
            backgroundColor: Colors.redAccent,
            content: Text('Username already exists'),
          ));
          break;
        }
      default:
        {
          setState(() {
            showCircularProgressIndicator = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(milliseconds: 700),
            backgroundColor: Colors.redAccent,
            content: Text('Email already exists'),
          ));
          break;
        }
    }
  }

  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  final double fontSize = 34;

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/sign_up_logo.png'),
                        width: 300,
                      ),
                      Container(
                        height: 100,
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome,',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: fontSize,
                                fontFamily: 'Oxygen',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Sign Up Now.',
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
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
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
                          keyboardType: TextInputType.name,
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
                                Icons.person_outline_outlined,
                                color: Colors.black54,
                              ),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.black54)),
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter a username.";
                            }
                            setState(() {
                              username = val;
                              validUsername = true;
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
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
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
                              labelText: 'Password Confirmation',
                              labelStyle: TextStyle(color: Colors.black54)),
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter a password confirmation.";
                            } else if (val != password) {
                              return "Wrong password confirmation.";
                            }
                            setState(() {
                              passwordConf = val;
                            });
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              passwordConf = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 30,
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up as a Tour guide?',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Switch.adaptive(
                                  value: isTourGuide,
                                  onChanged: (value) {
                                    setState(() {
                                      isTourGuide = value;
                                      print(isTourGuide);
                                    });
                                  })
                            ],
                          ),
                        ),
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
                                  // ignore: unrelated_type_equality_checks

                                  if (_formKey.currentState.validate()) {
                                    showCircularProgressIndicator = true;
                                    String tempdata = await (auth.signUp(
                                        email,
                                        password,
                                        username,
                                        isTourGuide,
                                        context));
                                    switcher(tempdata);
                                    setState(() {
                                      showCircularProgressIndicator = false;
                                    });
                                    print(tempdata);
                                  }
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Oxygen",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
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
