import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

class ContactScreen extends StatelessWidget {
  final String emailAddress = 'info@integramicro.com';
  final String phoneNumber = '+91-8028565801';

  void _launchEmailClient() async {
    final url = 'mailto:$emailAddress';
    try {
      await launch(url);
    } catch (e) {
      print('Error launching email client: $e');
    }
  }

  void _launchPhoneDialer() async {
    final url = 'tel:$phoneNumber';
    try {
      await launch(url);
    } catch (e) {
      print('Error launching phone dialer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(
        context,
        children: [
          Card(
            margin: EdgeInsets.only(top: 25, left: 16, right: 16, bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.emailContact,
                          style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '\n',
                        ),
                        TextSpan(
                          text: emailAddress,
                          style: TextStyle(fontSize: 15, color: Colors.lightGreen, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = _launchEmailClient,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.grey,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.phoneContact,
                          style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '\n',
                        ),
                        TextSpan(
                          text: phoneNumber,
                          style: TextStyle(fontSize: 15, color: Colors.lightGreen, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = _launchPhoneDialer,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppStrings.officeAddress, style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
