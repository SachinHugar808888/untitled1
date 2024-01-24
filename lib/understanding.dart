/*
import 'package:flutter/material.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';


class FacilitatorDashboard extends StatelessWidget {
  final String resetPassword;
  final String resetPasswordMsg;
  final String lastLoginTime;

  FacilitatorDashboard({
    required this.resetPassword,
    required this.resetPasswordMsg,
    required this.lastLoginTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Expanded(
              child: ResponsiveWidgetBuilder.buildResponsiveContainer(
                context,
                children: [
                  buildFacilitatedList(context),
                  buildFacilitatedRequestList(context),
                  buildCommissionEarnedList(context),
                  buildPendingRequestList(context),
                ],
              ),
            ),
          ],
        ),
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
            Navigator.pop(context);
          }),
          buildDrawerItem('Borrower Registration', Icons.app_registration, () {
            Navigator.pop(context);
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
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "About"),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.amber[800],
      onTap: (int index) {},
    );
  }

  Widget buildFacilitatedList(BuildContext context) {
    // Replace this with your actual implementation for Facilitated Amount
    return ListView(
      children: const [
        Card(
          color: Colors.blue,
          child: ListTile(
            title: Text("Facilitated Amount 1"),
          ),
        ),
        Card(
          color: Colors.blue,
          child: ListTile(
            title: Text("Facilitated Amount 2"),
          ),
        ),
        // ... add more items as needed
      ],
    );
  }

  Widget buildFacilitatedRequestList(BuildContext context) {
    // Replace this with your actual implementation for Facilitated Request
    return ListView(
      children: const [
        Card(
          child: ListTile(
            title: Text("Facilitated Request 1"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text("Facilitated Request 2"),
          ),
        ),
        // ... add more items as needed
      ],
    );
  }

  Widget buildCommissionEarnedList(BuildContext context) {
    // Replace this with your actual implementation for Commission Earned
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: Text("Commission Earned 1"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text("Commission Earned 2"),
          ),
        ),
        // ... add more items as needed
      ],
    );
  }

  Widget buildPendingRequestList(BuildContext context) {
    // Replace this with your actual implementation for Pending Request
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: Text("Pending Request 1"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text("Pending Request 2"),
          ),
        ),
        // ... add more items as needed
      ],
    );
  }
}*/
