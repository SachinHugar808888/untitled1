import 'package:flutter/material.dart';
import 'package:untitled1/Controller/global_class.dart';
import 'package:untitled1/View/SystemUserDashboard/bulkRegistration.dart';
import 'package:untitled1/View/SystemUserDashboard/video_kyc/video_kyc_request.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SystemUserDashboard(),
        ),
      ),
    );
  }
}

class SystemUserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userName = GlobalValues.getUserName();
    bool isDesktop = ResponsiveWidgetBuilder.isDesktop(context);

    return ResponsiveWidgetBuilder.buildResponsiveContainer(
      context,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome $userName',
                    style: TextStyle(fontSize: 20, color: Colors.black26)),
                Spacer(),
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage("images/img_1.png"),
                ),
              ],
            ),
          ),
        ),
        if (isDesktop)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1, // Adjust the flex factor as needed
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoKycRequest()),
                        );
                      },
                      child: _buildCard(
                        context,
                        Icons.video_call_rounded,
                        AppStrings.kycVerification,
                        Colors.teal,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BulkRegistration()),
                        );
                      },
                      child: _buildCard(
                        context,
                        Icons.list,
                        AppStrings.grievance,
                        Colors.blueAccent,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: _buildCard(
                      context,
                      Icons.pending_actions,
                      AppStrings.documentverification,
                      Colors.black26,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: _buildCard(
                      context,
                      Icons.manage_accounts,
                      AppStrings.facilitatorEvalator,
                      Colors.green,
                    ),
                  ),
                  Flexible(
                    child: _buildCard(
                      context,
                      Icons.credit_card_off_rounded,
                      AppStrings.platformsigning,
                      Colors.deepOrange,
                    ),
                  ),
                  Flexible(
                    child: _buildCard(
                      context,
                      Icons.document_scanner_sharp,
                      AppStrings.vkycaudit,
                      Colors.indigo,
                    ),
                  ),
                ],
              ),

            ],
          ),
        if (!isDesktop)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoKycRequest()),
                        );
                      },
                      child: _buildCard(
                        context,
                        Icons.video_call_rounded,
                        AppStrings.kycVerification,
                        Colors.teal,
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BulkRegistration()),
                        );
                      },
                      child: _buildCard(
                        context,
                        Icons.list,
                        AppStrings.grievance,
                        Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: _buildCard(
                      context,
                      Icons.pending_actions,
                      AppStrings.documentverification,
                      Colors.black26,
                    ),
                  ),
                  Flexible(
                    child: _buildCard(
                      context,
                      Icons.manage_accounts,
                      AppStrings.facilitatorEvalator,
                      Colors.green,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: _buildCard(
                      context,
                      Icons.credit_card_off_rounded,
                      AppStrings.platformsigning,
                      Colors.deepOrange,
                    ),
                  ),
                  Flexible(
                    child: _buildCard(
                      context,
                      Icons.document_scanner_sharp,
                      AppStrings.vkycaudit,
                      Colors.indigo,
                    ),
                  ),
                ],
              ),
            ],
          ),

      ],
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String cardText,
      Color color) {
    double cardHeight = 100.0; // Set your desired fixed height
    return Card(
      elevation: 3,
      child: Container(
        width: ResponsiveWidgetBuilder.isDesktop(context)
            ? MediaQuery
            .of(context)
            .size
            .width / 3
            : MediaQuery
            .of(context)
            .size
            .width / 2,
        height: cardHeight,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Icon(icon),
            SizedBox(height: 8),
            Text(
              cardText,
              style: TextStyle(fontSize: 16), // Adjust the font size as needed
            ),
          ],
        ),
      ),
    );
  }
}
