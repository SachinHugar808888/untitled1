import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:untitled1/Controller/dialog_helper.dart';
import 'package:untitled1/Model/SytemUser/vkyc_requestdata.dart';

import 'package:untitled1/main.dart';
import 'package:untitled1/res/colors.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

import '../../../Controller/custom_progress_dialog.dart';
import '../../../Controller/jlg_group_api.dart';

import '../../../Network/shared_preferences.dart';
import '../../../util/ApiConstants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../screens/verification/webview_screen.dart';

class VideoKycRequest extends StatefulWidget {
  @override
  State<VideoKycRequest> createState() => _VideoKycRequestState();
}

class _VideoKycRequestState extends State<VideoKycRequest> {
  List<VKYCRequestData> requests = [];

  @override
  void initState() {
    super.initState();
    initializeData();
    print('Number of requests: ${requests.length}');
  }

  @override
  Widget build(BuildContext context) {
    requests.sort((a, b) => b.requestedon.compareTo(a.requestedon));
    return Scaffold(   
      appBar: AppBar(
        title: Text('Video KYC Request'),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(
        context,
        children: [
          for (var request in requests)
            _buildCard(
                context,
                request.name,
                request.requestedon,
                request.vkycreqno,
                AppColors.lightBlue,
                request.utype
            ),


        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String name, String date,
      String vkycreqno, Color color, int utype) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: color,
      child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('UserName',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(name, style: TextStyle(fontWeight: FontWeight.w300)),
                  ],
                ),
                Column(
                  children: [
                    Text('RequestedDate',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(date, style: TextStyle(fontWeight: FontWeight.w300)),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text('RequestedId',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                // Add some space between the title and subtitle
                Text(vkycreqno, style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey), // Add a Divider
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 8),
              ElevatedButton(onPressed: () {
                acceptKycRequest(utype, vkycreqno);
              }, child: Text('Accept'), style: ElevatedButton.styleFrom(
                //primary: Colors.teal, // Set button color
                textStyle: TextStyle(fontSize: 16), // Set text style
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Set padding
              ),),
              SizedBox(width: 8),
              // Add some space between the button and the edge
            ],
          ),
        ],
      ),
    );
  }


  void initializeData() async {
    ProgressDialogHelper.show(context);
    Map<String, dynamic> response = await JLGApiService().makeApiRequest(
      ApiConstants.vkycrequest,
      requiresAccessToken: true,
      httpMethod: HttpMethod.get,
    );

    print(response);

    if (response['status'] == "SUCCESS") {
      ProgressDialogHelper.hide();
      List<dynamic> msgdata = response['msgdata'];
      List<VKYCRequestData> vkycRequest = msgdata.map((data) =>
          VKYCRequestData(
              vkycreqno: data['vkycreqno'],
              memmid: data['memmid'],
              name: data['name'],
              requestedon: data['requestedon'],
              utype: data['utype']
          )).toList();

      setState(() {
        requests = vkycRequest;
      });
    } else {
      ProgressDialogHelper.hide();
      print('API request failed');
    }
  }

  void acceptKycRequest(int utype, String vkycreqno) async {
    String acceptRequestUrl = "vf/acceptvkycrequest?vkycreqno=$vkycreqno&utype=$utype";

    Map<String, dynamic> response = await JLGApiService().makeApiRequest(
      acceptRequestUrl,
      requiresAccessToken: true,
      httpMethod: HttpMethod.get,
    );
    print(response);
    if (response.containsKey('status') && response['status'] == 'SUCCESS') {
      Map<String, dynamic> msgData = response['msgdata'];

      String sessionId = msgData['sessionId'];
      String participantId = msgData['participantId'];
      String accessToken = msgData['accessToken'];
      String externalParticipantId = msgData['externalParticipantId'];

      launchCustomTab(
          sessionId, participantId, accessToken, externalParticipantId);
    } else {
      // Handle other response scenarios if needed
    }
  }

  void launchCustomTab(String sessionId, String participantId,
      String accessToken, String externalParticipantId) async {
    String role = "agent";
    String device = "mobile";
    String token = await SharedPreferencesHelper.getAccessToken();

    String url = "${ApiConstants
        .baseUrl}VkycBoot/videoSession?sessionId=$sessionId&participantId=$participantId&token=$accessToken&role=$role&device=$device&accessToken=$token&memmId=$externalParticipantId&device=$device";

    try {
      await launch(url).then((_) {
        // Callback executed after the URL has been launched
        DialogHelper.showCustomDialog(context, 'Video KYC Successfull', () {
          // This function will be called when the dialog is closed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyLoginPage()),
          );
        });
      });
    } catch (e) {
      print('Error launching URL: $e');
      // Handle the error, show a message, or perform fallback action.
    }

  }
}
