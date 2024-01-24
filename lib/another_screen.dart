import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  TextEditingController textField3Controller = TextEditingController();
  TextEditingController textField4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textField3Controller,
              decoration: InputDecoration(labelText: 'TextField 3'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: textField4Controller,
              decoration: InputDecoration(labelText: 'TextField 4'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your button onPressed logic for the second screen here
                String text3 = textField3Controller.text;
                String text4 = textField4Controller.text;
                print('TextField 3: $text3, TextField 4: $text4');
              },
              child: Text('Next Screen Button'),
            ),
          ],
        ),
      ),
    );
  }
}