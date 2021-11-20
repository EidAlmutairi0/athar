import 'package:flutter/material.dart';

class VRScreen extends StatefulWidget {
  String placeName;
  List VRimages;

  VRScreen(var placeName, List images) {
    this.placeName = placeName;
    VRimages = images;
  }

  @override
  State<VRScreen> createState() => _VRScreenState();
}

class _VRScreenState extends State<VRScreen> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placeName),
        centerTitle: true,
        backgroundColor: Color(0xFFF2945E),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              child: widget.VRimages[imageIndex],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (imageIndex == 0)
                          ? null
                          : () {
                              setState(() {
                                imageIndex--;
                              });
                            },
                      child: Icon(Icons.arrow_back)),
                  ElevatedButton(
                      onPressed: (imageIndex == widget.VRimages.length - 1)
                          ? null
                          : () {
                              setState(() {
                                imageIndex++;
                              });
                            },
                      child: Icon(Icons.arrow_forward)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
