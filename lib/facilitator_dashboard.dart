import 'package:flutter/material.dart';
import 'package:untitled1/View/auth/customer_support.dart';
import 'package:untitled1/View/auth/jlg_registration.dart';
import 'package:untitled1/View/screens/dashboard.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'View/auth/profile_dashboard/profile_mainScreen.dart';
import 'View/screens/notifications/local_notification.dart';
import 'main.dart';

class FacilitatorDashboard extends StatefulWidget {
  final String resetPassword;
  final String resetPasswordMsg;


  FacilitatorDashboard({
    required this.resetPassword,
    required this.resetPasswordMsg,

  });

  @override
  State<FacilitatorDashboard> createState() => _FacilitatorDashboardState();
}

class _FacilitatorDashboardState extends State<FacilitatorDashboard> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ResponsiveWidgetBuilder.buildResponsiveContainer(
            context,
            children: [
              buildFacilitatedCard(context),
              buildFacilitatedRequestList(context),
              /*buildCommissionEarnedList(context),
              buildPendingRequestList(context),*/
            ],
          );
        },
      ),

        bottomNavigationBar: ResponsiveWidgetBuilder.isDesktop(context)
          ? null
          : buildMobileBottomNavigationBar(context),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Facilitator Dashboard'),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'images/img_1.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Sachin',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          buildDrawerItem('Dashboard', Icons.dashboard, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),));
          }),
          buildDrawerItem('Profile', Icons.app_registration, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));

          }),
          buildDrawerItem('Create JLG', Icons.groups_outlined, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => JLGRegistration(),));
          }),
          buildDrawerItem('Support', Icons.contact_support_sharp, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerSupport(),));
          }),
          buildDrawerItem('Logout', Icons.contact_support_sharp, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyLoginPage(),));
          }),
          buildDrawerItem('LocalNotification', Icons.notifications, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LocalNotification(),));
          }),
          // ... add more drawer items as needed
        ],
      ),
    );
  }

  Widget buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget buildMobileBottomNavigationBar(BuildContext context) {
    return BottomNavyBar(

      selectedIndex: _currentIndex,
      showElevation: true, // use this to hide AppBar's elevation
      onItemSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Home'),
          activeColor:Colors.blue,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.info),
          title: Text('Profile'),
          activeColor: Colors.blue,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.dashboard),
          title: Text('About'),
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}

  Widget buildFacilitatedCard(BuildContext context) {
    return ResponsiveWidgetBuilder.isDesktop(context)
        ? buildDesktopFacilitatedCard(context)
        : buildMobileFacilitatedCard(context);
  }

Widget buildDesktopFacilitatedCard(BuildContext context) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.black, width: 1.0), // Border color and width
      borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              buildSubCard(context, AppStrings.commissionEarned, const Icon(Icons.currency_rupee), "0.00", const EdgeInsets.all(8.0), Colors.blue),
              // Add more texts or widgets as needed
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              buildSubCard(context, AppStrings.commissionEarned, const Icon(Icons.currency_rupee), "0.00", const EdgeInsets.all(8.0), Colors.blue),
              // Add more texts or widgets as needed
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMobileFacilitatedCard(BuildContext context) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.red, width: 1.0), // Border color and width
      borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildSubCard(context, AppStrings.commissionEarned, const Icon(Icons.currency_rupee), "0.00", const EdgeInsets.all(8.0), Colors.blue),
            buildSubCard(context, AppStrings.commissionEarned, const Icon(Icons.currency_rupee), "0.00", const EdgeInsets.all(8.0), Colors.blue),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildSubCard(context, AppStrings.commissionEarned, const Icon(Icons.currency_rupee), "0.00", const EdgeInsets.all(8.0), Colors.blue),
            buildSubCard(context, AppStrings.commissionEarned, const Icon(Icons.currency_rupee), "0.00", const EdgeInsets.all(8.0), Colors.blue),
          ],
        ),
      ],
    ),
  );
}

Widget buildSubCard(BuildContext context, String title, Widget icon, String value, EdgeInsets padding, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: Colors.green, width: 1.0), // Border color and width
      borderRadius: BorderRadius.circular(4.0), // Adjust border radius as needed
    ),
    padding: padding,
    child: Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              value,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ],
    ),
  );
}




Widget buildFacilitatedRequestList(BuildContext context) {
  return Card(
    child:Image.asset(
     "images/p2pl.png",
      width:double.infinity,

      fit: BoxFit.cover, // Adjust the BoxFit based on your image requirements
    ),
  );
}


Widget buildCommissionEarnedList(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("Commission Earned 1"),
          ),
          ListTile(
            title: Text("Commission Earned 2"),
          ),
          // ... add more items as needed
        ],
      ),
    );
  }

  Widget buildPendingRequestList(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("Pending Request 1"),
          ),
          ListTile(
            title: Text("Pending Request 2"),
          ),
          // ... add more items as needed
        ],
      ),
    );
  }

