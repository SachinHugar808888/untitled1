import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Controller/custom_dialog.dart';
import 'package:untitled1/Controller/custom_dialogs.dart';
import 'package:untitled1/Controller/global_class.dart';
import 'package:untitled1/View/screens/verification/webview_screen.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

import 'package:untitled1/util/verification_flags.dart';

import '../../../Controller/custom_alert_dialog.dart';
import '../../../Controller/jlg_group_api.dart';
import '../../../Controller/web_view.dart';
import '../../../Network/shared_preferences.dart';
import '../../../main.dart';
import '../../../util/ApiConstants.dart';
import 'package:url_launcher/url_launcher.dart';


class VerificationScreen extends StatefulWidget{
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isVkycVerified = VerificationFlags.isVkycVerified;
  late Timer timer;
  late String vkycreqno;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.verify),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(context,
          children: [
            Visibility(
              visible: isVkycVerified == 1,
              child: buildCard(AppStrings.kycStatus, Icons.verified, () {

              }),
            ),
            Visibility(
              visible: isVkycVerified != 1,
              child: buildCard(AppStrings.kycDocument, Icons.edit_document, () {

              }),
            ),
            Visibility(
              visible: isVkycVerified != 1,
              child: buildCard(
                  AppStrings.videoKyc, Icons.video_call_rounded, () {
                showAlertDialog(context);
              }),
            ),

          ]),
    );
  }

  Card buildCard(String text, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Instructions"),
          content: Text(
            "Follow the instructions regarding camera, mic, and location access as they appear on the next screen.\n\n" +
                "1) Keep your PAN Card handy for the Video KYC session.\n" +
                "2) Ensure you are in a well-lit surrounding.\n" +
                "3) Make sure there is no background noise or disturbance.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Dismiss"),
            ),
            ElevatedButton(
              onPressed: () {
                createVkycRequestService();
                Navigator.of(context).pop();
              },
              child: Text("Proceed"),
            ),
          ],
        );
      },
    );
  }

  void createVkycRequestService() async {
    Map<String, dynamic> response = await JLGApiService().makeApiRequest(
      ApiConstants.createKycRequest,
      requiresAccessToken: true,
      httpMethod: HttpMethod.get,
    );

    // Check if the response code is 0000 (assuming 0000 indicates success)
    if (response['code'] == '0000') {
      // If successful, print the value of 'vkycreqno'
      vkycreqno = response['msgdata']['vkycreqno'];
      print('VKYC session request raised, vkycreqno: $vkycreqno');

      // Schedule a periodic task to call getVkycRequestStatusService every 10 seconds
      const Duration delay = Duration(seconds: 10);
      timer = Timer.periodic(delay, (Timer timer) {
        getVkycRequestStatusService();
      });
    } else {
      // If not successful, print the error message
      String errorMessage = response['message'];
      CustomDialogs.showError(context, errorMessage);
    }
  }

  void getVkycRequestStatusService() async {
    String utype = "CUST";
    String loadRequestUrl = "vf/getvkycrequeststatus?vkycreqno=$vkycreqno&usermode=$utype";
    Map<String, dynamic> response = await JLGApiService().makeApiRequest(
      loadRequestUrl,
      requiresAccessToken: true,
      httpMethod: HttpMethod.get,

    );
    print(response);
    if (response.containsKey('status') && response['status'] == 'SUCCESS') {
      Map<String, dynamic> msgData = response['msgdata'];
      if (response['message'] == "VKYC session details") {
        String sessionId = msgData['sessionId'];
        String participantId = msgData['participantId'];
        String accessToken = msgData['accessToken'];
        String externalParticipantId = msgData['externalParticipantId'];
        timer.cancel();


        launchCustomTab(
            sessionId, participantId, accessToken, externalParticipantId);
      }
    } else {
      // Handle other response scenarios if needed
    }
  }

  void launchCustomTab(String sessionId, String participantId,
      String accessToken, String externalParticipantId) async {
    String role = "agent";
    String device = "mobile";
    String token = await SharedPreferencesHelper.getAccessToken();
    // Assuming you have a token

    String url = "${ApiConstants
        .baseUrl}VkycBoot/videoSession?sessionId=$sessionId&participantId=$participantId&token=$accessToken&role=$role&device=$device&accessToken=$token&memmId=$externalParticipantId&device=$device";
    try {
      if (kIsWeb) {
        await launch(url);
      } else {
        await launch(url);
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error, show a message, or perform fallback action.
    }
  }
}
