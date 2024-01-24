import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/View/widgets/text_Field_Widgets.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

class TicketScreen extends StatelessWidget{
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController userName = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raise Ticket'),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(context,
          children: [
            Card(
              child: Column(
                children: [

                  CustomTextField(controller: userName, labelText:'Please Enter Your UserName', suffixIcon: Icons.person, keyboardType: TextInputType.text),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: mobileNumber,
                    labelText: 'Enter your Mobile Number', suffixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),

                ],
              ),
            )


          ]),
    );
  }

}