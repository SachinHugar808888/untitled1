import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:untitled1/Controller/global_class.dart';

import 'package:untitled1/View/auth/jlg_registration.dart';
import 'package:untitled1/network/api_service.dart';
import 'package:untitled1/network/http_overrides.dart';
import 'package:untitled1/network/shared_preferences.dart';
import 'package:untitled1/util/ApiConstants.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';
import 'package:untitled1/util/verification_flags.dart';

import 'Controller/custom_progress_dialog.dart';

import 'Controller/jlg_group_api.dart';
import 'View/SystemUserDashboard/login_screen.dart';
import 'facilitator_dashboard.dart';

void main() async {
  setupHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: const MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<Map<String, dynamic>> _loginFuture = Future.value({});
  bool userLoggedIn = false;

  @override
  void initState() {
    super.initState();

    // Set initial values for the controllers
    mobileController.text = "ILANGO";
    passwordController.text = "ayushi0607@";

    // Request notification permissions

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(
        context,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: const EdgeInsets.all(16.0),
        children: [
          ClipOval(
            child: Image.asset(
              "images/logo.jpg",
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: mobileController,
            decoration: InputDecoration(
              labelText: "Enter Your Mobile Number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: const Icon(Icons.phone),
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: const Icon(Icons.password),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Forgot Password?",
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle register button press
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 50),
                ),
                child: const Text("Register"),
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
                  }
                  ProgressDialogHelper.show(context);

                  // Base64 encode the mobile number and password
                  String base64Mobile = base64.encode(utf8.encode(mobile));
                  String base64Password = base64.encode(utf8.encode(password));
                  Map<String, dynamic> requestData = {
                    "username": base64Mobile,
                    "userpassword": base64Password,



                  };

                  try {
                    Map<String, dynamic> response = await JLGApiService().makeApiRequest(
                      ApiConstants.loginEndpoint,
                      requestData: requestData,
                      requiresAccessToken: false,
                      httpMethod: HttpMethod.post,
                    );

                    print(response);
                    var code = response['code'];
                    // ... (Your existing code)

                    if (code != null) {
                      String codeString = code.toString();
                      if (codeString == '0000') {
                        Map<String, dynamic>? userData = response["data"];
                        if (userData != null) {
                          userLoggedIn = true;
                          GlobalValues.setUserLogged(userLoggedIn);

                          int? memId = userData['memmid'];
                          if (memId != null) {
                            String accessToken = userData['accessToken'] ?? '';
                            await SharedPreferencesHelper.saveMemid(memId);
                            await SharedPreferencesHelper.saveAccessToken(accessToken);

                            Map<String, dynamic>? flags = userData["flags"];
                            if (flags != null) {
                              VerificationFlags.isPanVerified = flags['isPanVerified'] == 1;
                              VerificationFlags.isAddressVerified = flags['isAddressVerified'] == 1;
                              VerificationFlags.isTnCSigned = flags['isTnCSigned'] == 1;
                              VerificationFlags.isMobileVerified = flags['isMobileVerified'] == 1;
                              VerificationFlags.isAccountVerified = flags['isAccountVerified'] == 1;
                              VerificationFlags.isTxnPinEnabled = flags['isTxnPinEnabled'] == 1;
                              VerificationFlags.isReferenceVerified = flags['isReferenceVerified'] == 1;
                              VerificationFlags.isEmailVerified = flags['isEmailVerified'] == 1;
                              VerificationFlags.isVkycVerified = flags['isVkycVerified'] == 1;

                              // Add similar boolean flags handling for other flags

                              var userName = userData['userName'];
                              var logintype = userData['logintype'] ?? 0;
                              var resetPassword = userData['8088889297'] ?? '';
                              var resetPasswordMsg = userData['Success'] ?? '';
                              ProgressDialogHelper.hide();




                              List<int>? availableUserTypes = userData['availableusertypes']?.cast<int>() ?? [];
                              if (logintype == 3 || (availableUserTypes?.contains(3) == true)) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FacilitatorDashboard(
                                      resetPassword: resetPassword ?? '',
                                      resetPasswordMsg: resetPasswordMsg ?? '',

                                    ),
                                  ),
                                );
                              } else if (logintype == 1) {
                                var userName = userData['userName'] ?? ''; // Provide a default value if 'userName' is null
                                GlobalValues.setUserName(userName);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SystemUserDashboard()),
                                );
                              }

                            } else {
                              ProgressDialogHelper.hide();
                              print('Error: "flags" is null or not present in the response');
                            }
                          } else {
                            ProgressDialogHelper.hide();
                            print('Error: "memid" is null or not present in the response');
                          }
                        } else {
                          ProgressDialogHelper.hide();
                          print('Error: "userData" is null or not present in the response');
                        }
                      } else {
                        ProgressDialogHelper.hide();
                        var errorMessage = response['message'];
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(errorMessage),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }

                  } catch (e) {
                    ProgressDialogHelper.hide();
                    // Handle DioError or other exceptions
                    print('Error: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 50),
                ),
                child: const Text("Login"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
    );
  }

  Future<void> populateData() async {
    final userData = await _loginFuture;
    int memId = userData?['memmid'];
    String accessToken = userData?['accessToken'];
    await SharedPreferencesHelper.saveMemid(memId);
    await SharedPreferencesHelper.saveAccessToken(accessToken);

    Map<String, dynamic> flags = userData["flags"];
    bool isPanVerified = flags['isPanVerified'] == 1;
    bool isAddressVerified = flags['isAddressVerified'] == 1;
    bool isTnCSigned = flags['isTnCSigned'] == 1;
    bool isMobileVerified = flags['isMobileVerified'] == 1;
    bool isAccountVerified = flags['isAccountVerified'] == 1;
    bool isTxnPinEnabled = flags['isTxnPinEnabled'] == 1;
    bool isReferenceVerified = flags['isReferenceVerified'] == 1;
    bool isEmailVerified = flags['isEmailVerified'] == 1;
    bool isVkycVerified = flags['isVkycVerified'] == 1;

    var userName = userData['userName'];
    var logintype = userData['logintype'];
    var resetPassword = userData['8088889297'] ?? '';
    var resetPasswordMsg = userData['Success'] ?? '';

    var lastLoginTime = userData['lastlogintime'];
    await SharedPreferencesHelper.setUserName(userName);

    if (logintype == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FacilitatorDashboard(
            resetPassword: resetPassword,
            resetPasswordMsg: resetPasswordMsg,

          ),
        ),
      );
    }
  }




}


