import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

import '../../screens/verification/verification_screen.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profile),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(
        context,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("images/img_1.png"),
                ),
                Positioned(
                  bottom: 0,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
          buildCard(AppStrings.verify, Icons.verified, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen(),));

          }),
          buildCard(AppStrings.bankDetails, Icons.account_balance, () {
            // Handle Bank Details card click
          }),
          buildCard(AppStrings.userDetails, Icons.person, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen(),));

            // Handle User Details card click
          }),
          buildCard(AppStrings.changePassword, Icons.lock, () {
            // Handle Change Password card click
          }),
          buildCard(AppStrings.changeLanguage, Icons.language, () {
            // Handle Change Language card click
          }),
        ],
      ),
    );
  }

  GestureDetector buildCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    title,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
