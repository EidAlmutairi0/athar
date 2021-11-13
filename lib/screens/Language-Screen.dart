import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  int value;
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2945E),
        title: Text('Language'),
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
                      title: Text('English'),
                    ),
                  ),
                  Radio(
                      value: 1,
                      groupValue: widget.value,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
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
                      title: Text('Arabic'),
                    ),
                  ),
                  Radio(
                      value: 2,
                      groupValue: widget.value,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
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
