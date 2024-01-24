import 'package:flutter/material.dart';
import 'package:untitled1/View/auth/support_raise_ticket.dart';
import 'package:untitled1/View/auth/testing_TextField.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

import 'contact_screen.dart';

class CustomerSupport extends StatelessWidget {
  void _handleCardTap(BuildContext context, String action) {
    // You can perform actions based on the tapped card (e.g., navigate to a new screen).
    switch (action) {
      case 'Contact':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen()));
        break;
      case 'Chat':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
        break;
      case 'Ticket':
        Navigator.push(context, MaterialPageRoute(builder: (context) => TicketScreen()));
        break;
      case 'ViewTicket':
        Navigator.push(context, MaterialPageRoute(builder: (context) => TextForm()));
        break;
    }
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String action) {
    return GestureDetector(
      onTap: () => _handleCardTap(context, action),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(width: 8.0),
              Icon(
                icon,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Support'),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(
        context,
        children: [
          Center(
            child: Card(
              margin: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 15),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.supportHeader,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 15.0),
                    _buildCard(context, AppStrings.supportContact, Icons.play_circle_fill, 'Contact'),
                    SizedBox(height: 15.0),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 15.0),
                    _buildCard(context, AppStrings.supportChatwithCustomer, Icons.play_circle_fill, 'Chat'),
                    SizedBox(height: 15.0),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 15.0),
                    _buildCard(context, AppStrings.supportTicket, Icons.play_circle_fill, 'Ticket'),
                    SizedBox(height: 15.0),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 15.0),
                    _buildCard(context, AppStrings.supportViewTicket, Icons.play_circle_fill, 'ViewTicket'),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Screen'),
      ),
      body: Center(
        child: Text('This is the Contact Screen'),
      ),
    );
  }
}*/

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Center(
        child: Text('This is the Chat Screen'),
      ),
    );
  }
}

/*
class TicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Screen'),
      ),
      body: Center(
        child: Text('This is the Ticket Screen'),
      ),
    );
  }
}
*/

class ViewTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Ticket Screen'),
      ),
      body: Center(
        child: Text('This is the View Ticket Screen'),
      ),
    );
  }
}
