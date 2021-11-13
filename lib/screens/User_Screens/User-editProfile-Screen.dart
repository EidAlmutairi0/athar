import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athar/providers/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UserEditProfileScreen extends StatefulWidget {
  @override
  _UserEditProfileScreenState createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final storage = FirebaseStorage.instance;

  File avatar;
  File header;

  Future upLaodfile(File av, File he) async {
    if (av != null) {
      await storage
          .ref("${Authentication.currntUsername}/avatar")
          .putFile(av)
          .then((p0) async {
        var url = await p0.ref.getDownloadURL();
        print(url);
        FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(Authentication.currntUsername)
            .update({'avatar': url});
      });
    }
    if (he != null) {
      await storage
          .ref("${Authentication.currntUsername}/header")
          .putFile(he)
          .then((p0) async {
        var url = await p0.ref.getDownloadURL();
        print(url);
        FirebaseFirestore.instance
            .collection('users')
            .doc('normalUsers')
            .collection('normalUsers')
            .doc(Authentication.currntUsername)
            .update({
          'header': url,
        });
      });
    }
  }

  Future getAvatar() async {
    final PickedFile image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        avatar = File(image.path);
      });
      print(image.path);
    }
  }

  Future getHeader() async {
    final PickedFile image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        header = File(image.path);
      });
      print(image.path);
    }
  }

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
                    InkWell(
                      onTap: getHeader,
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: (header == null)
                            ? Icon(
                                Icons.add,
                                color: Colors.grey,
                                size: 40,
                              )
                            : Image.file(
                                header,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 20,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(70),
                        onTap: getAvatar,
                        child: CircleAvatar(
                          child: (avatar == null)
                              ? Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 40,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.file(avatar),
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
                            upLaodfile(avatar, header).whenComplete(() {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Changing has been saved'),
                                backgroundColor: Colors.green,
                              ));
                              setState(() {
                                isPressed = false;
                              });
                            });
                            if (name != null || name != '') {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc('normalUsers')
                                  .collection('normalUsers')
                                  .doc(Authentication.currntUsername)
                                  .update({'name': name});
                            }
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
