import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/providers/auth.dart';

class UserEditProfileScreen extends StatefulWidget {
  @override
  _UserEditProfileScreenState createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        title: Text('Edit profile'),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 20,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(70),
                        onTap: () {},
                        child: CircleAvatar(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 40,
                          ),
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),

                    // Container(
                    //   child: ,
                    // )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
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
                              name = val;
                            });
                            print(name);
                          },
                          onSaved: (val) {
                            setState(() {
                              name = val;
                            });
                            print(name);
                          },
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
                              labelStyle: TextStyle(color: Colors.black54)),
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter name.";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
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
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            setState(() {
                              isPressed = true;
                            });
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc('normalUsers')
                                .collection('normalUsers')
                                .doc(Authentication.currntUsername)
                                .update({'name': name}).whenComplete(() {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Changing has been saved'),
                                backgroundColor: Colors.green,
                              ));
                              setState(() {
                                isPressed = false;
                              });
                            });
                          },
                    child: (isPressed)
                        ? CircularProgressIndicator()
                        : Text(
                            'Save',
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
