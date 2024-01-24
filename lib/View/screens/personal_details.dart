import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

class PersonalDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(context,
          children: [
           /* buildProfileCard,
            buildPersonalDetails,
            buildAddressDetails
*/
          ]),
    );
  }

}