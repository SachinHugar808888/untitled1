import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

class TextForm extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField"),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(
        context,
        children: [
          Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Enter Password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password should not be empty";
                    } else if (value.length < 3) {
                      return "Password should not be less than 3 characters";
                    }
                    return null; // Return null if validation is successful
                  },
                  onChanged: (value) {
                    // Reset error state when text changes
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, hide the error message
                     /* setState(() {
                        passwordController.clear();
                      });*/
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, perform actions
                    String enteredPassword = passwordController.text;
                    print('Password is valid: $enteredPassword');
                  }
                },
                child: Text('Pressed'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
