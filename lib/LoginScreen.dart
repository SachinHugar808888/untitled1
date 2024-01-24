
// login_screen.dart
import 'dart:convert';
/*
import 'package:facilitatator/res/strings.dart';
import 'package:facilitatator/util/responsive_widget_builder.dart';*/
import 'package:flutter/material.dart';




import 'package:dio/dio.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';
/*
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  
final ApiClient _apiClient = ApiClient();*/
// Update based on your project structure

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.login),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ResponsiveWidgetBuilder.buildResponsiveContainer(
            context,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            padding: EdgeInsets.only(top: 30.0, right: 25, left: 25),
            children: [

ClipOval(
                child: Image.asset(
                  'images/img.png',
                  width: 100,
                  height: 100,
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(
                  labelText: "Enter Your Mobile Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: Icon(Icons.password),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [*/
           /*       ElevatedButton(
                    onPressed: () {
                      // Handle register button press
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(140, 50),
                    ),
                    child: Text("Register"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Handle login button press
                      String mobile = mobileController.text.trim();
                      String password = passwordController.text.trim();

                      // Validate if both fields are filled
                      if (mobile.isEmpty || password.isEmpty) {
                        print('Mobile number and password are required');
                        return;
                      }*/

                      // Base64 encode the mobile number and password
                    /*  String base64Mobile = base64.encode(utf8.encode(mobile));*/
                     /* String base64Password = base64.encode(utf8.encode(password));*/

                      // Construct the request data
                   /*   Map<String, dynamic> requestData = {
                        'mobile_number': base64Mobile,
                        'password': base64Password,
                      };*/


                        // Call the post method with the constructed requestData

/*final response = await _apiClient.postRequest(
                          'usrmgmt/p2pusers/v2/login', // Endpoint path
                          requestData,
                        );*//*


                        // Handle the login response here
                        */
/*print('Login Response: ${response.data}');*//*

                      } catch (error) {
                        // Handle errors, such as showing an error message to the user
                        print('Error: $error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(140, 50),
                    ),
                    child: Text("Login"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contact Us",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    Text(
                      "About",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    Text(
                      "Fair Practices",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    Text(
                      "Grievance Policy",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
