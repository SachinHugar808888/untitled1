import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:untitled1/Controller/global_class.dart';

import 'package:untitled1/View/screens/otp_screen.dart';

import 'package:untitled1/network/http_overrides.dart';
import 'package:untitled1/network/shared_preferences.dart';
import 'package:untitled1/util/ApiConstants.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

import 'Controller/custom_progress_dialog.dart';


import 'Controller/jlg_group_api.dart';


import 'Controller/key_pair_generator.dart';
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
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlueAccent,
        ),
      ),
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
  String? referenceNo;
  String? secretKey;
  String mobile = '';
  String password = '';


  @override
  void initState() {
    super.initState();

    // Set initial values for the controllers
    mobileController.text = "9005005005";
    passwordController.text = "Test@123";
//FAC-0000015780
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

                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 50),
                ),
                child: const Text("Register"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Handle login button press
                  ProgressDialogHelper.show(context);

                  mobile = mobileController.text.trim();
                  password = passwordController.text.trim();
                  GlobalValues.setMobile(mobile);


                  // Validate if both fields are filled
                  if (mobile.isEmpty || password.isEmpty) {
                    print('Mobile number and password are required');
                    return;
                  } else {
                    try {
                      loginServiceNew();
                     // generateSecretKey();
                    } catch (e) {
                      print(e);
                    }
                  }

                  // Base64 encode the mobile number and password

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

 /* Future<void> generateSecretKey() async {
    print("Platform check: ${kIsWeb ? "Web" : "Mobile"}");



    if (kIsWeb) {
      // Web-specific key generation
      final keyPair = await KeyUtils.generateRSAKeyPair();
      print("Public Key PEM: ${keyPair['publicKeyPem']}");
    } else {
      // Mobile-specific key generation using PointyCastle
      final pair = await KeyUtils.generateRSAKeyPair();  // Assuming this returns an AsymmetricKeyPair object
      final publicKeyPem = KeyUtils.encodePublicKeyToPem(pair.publicKey);  // Encode the public key to PEM
      print("Public Key PEM (Mobile): $publicKeyPem");
    }
  }*/



  void loginServiceNew() async {
    String base64Mobile = base64.encode(utf8.encode(mobile));
    String base64Password = base64.encode(utf8.encode(password));
    Map<String, dynamic> requestData = {
      "username": base64Mobile,
      "userpassword": base64Password,
    };
    bool isEncrypted = true;
    GlobalValues.setEncrypted(isEncrypted);

    try {
      Map<String, dynamic> response = await JLGApiService().makeApiRequest(
        ApiConstants.loginEndpoint,
        requestData: requestData,
        requiresAccessToken: false,
        httpMethod: HttpMethod.post,
      );

      print(response);
      var code = response['code'];

      if (code != null) {
        ProgressDialogHelper.hide();

        String codeString = code.toString();
        if (codeString == '0000') {
          Map<String, dynamic>? userData = response["data"];
          if (userData != null) {
            userLoggedIn = true;
            GlobalValues.setUserLogged(userLoggedIn);

            // Safely retrieve tokenType and accessToken
            String tokenType = userData['tokenType'] ??
                ''; // Provide default value if null
            String accessToken = userData['accessToken'] ??
                ''; // Provide default value if null

            int? memId = userData['memmid'];
            int? otpRef = userData['otpref'];

            if (memId != null) {
              await SharedPreferencesHelper.saveMemid(memId);
              await SharedPreferencesHelper.saveAccessToken(accessToken);

              if (otpRef != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OtpScreen(memmid: memId, otpref: otpRef),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FacilitatorDashboard(tokenType, accessToken),
                  ),
                );
              }
            } else {
              ProgressDialogHelper.hide();
              print('Error: "memid" is null or not present in the response');
            }
          } else {
            ProgressDialogHelper.hide();
            print('Error: "userData" is null or not present in the response');
          }
        }
        ProgressDialogHelper.hide();
      }
    } catch (e) {
      ProgressDialogHelper.hide();
      // Handle DioError or other exceptions
      print('Error: $e');
    }
  }

  Future<void> populateData() async {
    final userData = await _loginFuture;
    int memId = userData['memmid'];
    String accessToken = userData['accessToken'];
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
      /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FacilitatorDashboard(
                  resetPassword: resetPassword,
                  resetPasswordMsg: resetPasswordMsg,

                ),
          ),
        );*/
    }
  }
}

