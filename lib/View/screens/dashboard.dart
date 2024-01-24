import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/View/widgets/custom_button_widgets.dart';
import 'package:untitled1/View/widgets/text_Field_Widgets.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

class Dashboard extends StatelessWidget{
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(context,
          children: [
            Column(
              children: [
                CustomTextField(controller: mobile,
                    labelText: "Enter Mobile Number",
                    suffixIcon: Icons.phone,
                    keyboardType: TextInputType.phone),
                CustomTextField(controller: password,
                    labelText: "Enter Password",
                    suffixIcon: Icons.password,
                    keyboardType: TextInputType.text),
                TextField(
                  controller: userName,
                  decoration: InputDecoration(
                    labelText: "EnterUserName",
                    border: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(15)
                      ),
                    prefixIcon: Icon(Icons.verified_user),

                  ),
                )

              ],
            )
          ]),

    );
  }

}