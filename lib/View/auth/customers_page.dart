import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

import 'customer_support.dart';

class CustomersPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Sachin'),
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(context,
          children: [
            Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('Header',style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20,),
                  _smallCard(context,AppStrings.supportContact,Icons.contact_support,'contact')
                ],
              ),
            )
          ]),
    );
  }

 Widget _smallCard(BuildContext context,String text,IconData icons,String action) {
    return GestureDetector(
      onTap: () => _handleCards(context,action),
      child: Row(
        children: [
          Text(text),
          SizedBox(width: 30,),
          Icon(icons)

        ],

      ),


    );
 }

  void _handleCards(BuildContext context, String action) {
   switch(action) {
     case 'Contact'
       :break;
   }
  }

}