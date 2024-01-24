import 'package:flutter/material.dart';
import 'package:untitled1/Controller/custom_dialogs.dart';
import 'package:untitled1/Controller/global_class.dart';
import 'package:untitled1/Controller/jlg_group_api.dart';
import 'package:untitled1/Model/stateListModel.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:untitled1/View/widgets/custom_button_widgets.dart';
import 'package:untitled1/View/widgets/text_Field_Widgets.dart';
import 'package:untitled1/res/strings.dart';
import 'package:untitled1/util/ApiConstants.dart';
import 'package:untitled1/util/responsive_widget_builder.dart';

import '../../Controller/dialog_helper.dart';
import '../../Model/district_list_model.dart';
import '../../Model/taluk_names_model.dart';
import '../../Model/user_basic_info.dart';

class JLGRegistration extends StatefulWidget {
  @override
  _JLGRegistrationState createState() => _JLGRegistrationState();
}

class _JLGRegistrationState extends State<JLGRegistration> {
  final TextEditingController groupName = TextEditingController();
  TextEditingController groupDescription = TextEditingController();
  TextEditingController mobileNumberJLG = TextEditingController();
  String selectedAttributeValue = '';
  List<String> attributeValues = [];
  List<String> stateNames = [];
  String selectedState = "";
  String selectedStateCode = "";
  List<String> districtNames = [];
  List<String> talukNames = [];
  Map<String, String> stateNamesAndCodes = {};
  String selectedDistrict = "";
  String selectedTaluk ="";
  List<String> memberIdList = [];
  List<String> districtIds = [];
  late String status ;
  Widget? yourContentWidgetVariable;
  List<Widget> mobileWidgets = [];
  FocusNode groupNameFocusNode = FocusNode();
  FocusNode groupDescriptionFocusNode = FocusNode();
  FocusNode selectedAttributeValueFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();



  @override
  void initState() {
    super.initState();
    getInfo();
    getStateListService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("JLG Registration"),
        centerTitle: true,
      ),
      body: ResponsiveWidgetBuilder.buildResponsiveContainer(
        context,
        direction: Axis.vertical,
        children: [
          ClipOval(
            child: Image.asset(
              'images/img_2.png',
              width: 120,
              height: 120,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'JLG Creation',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: groupName,
            labelText: 'Enter Group Name ',
            suffixIcon: Icons.groups_outlined,
            keyboardType: TextInputType.text,
            focusNode: groupNameFocusNode,

          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: groupDescription,
            labelText: 'Enter Group Description ',
            suffixIcon: Icons.groups_outlined,
            keyboardType: TextInputType.text,
            focusNode: groupDescriptionFocusNode,

          ),
          SizedBox(height: 20),

          ResponsiveWidgetBuilder.isDesktop(context)
              ? Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: selectedAttributeValue),
                  decoration: InputDecoration(
                    labelText: AppStrings.occupation,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.people_alt_sharp),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (BuildContext context) {
                        return attributeValues.map((String attributeValue) {
                          return PopupMenuItem<String>(
                            value: attributeValue,
                            child: Text(attributeValue),
                          );
                        }).toList();
                      },
                      onSelected: (String selectedValue) {
                        setState(() {
                          selectedAttributeValue = selectedValue;
                        });
                      },
                    ),
                  ),
                  enableInteractiveSelection: false,
                  onTap: (){
                    // When tapped, remove the focus to hide the keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: selectedState),
                  decoration: InputDecoration(
                    labelText: AppStrings.state,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (BuildContext context) {
                        return stateNames.map((String state) {
                          return PopupMenuItem<String>(
                            value: stateNamesAndCodes[state], // Pass the state code
                            child: Text(state),
                          );
                        }).toList();
                      },
                      onSelected: (String selectedValue) {
                        setState(() {
                          selectedStateCode = selectedValue;

                          selectedState = stateNames.firstWhere((state) => stateNamesAndCodes[state] == selectedValue,
                              orElse: () => ""); // Update the selected state name
                          // Call the method to get the district list for the selected state code
                          print(selectedValue);
                          getDistrictListService(selectedValue);

                        });
                      },
                    ),
                  ),
                  enableInteractiveSelection: false,
                  onTap: (){
                    // When tapped, remove the focus to hide the keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
            ],
          )
              : Column(
            children: [
              TextField(
                  controller: TextEditingController(text: selectedAttributeValue),
                  decoration: InputDecoration(
                    labelText: AppStrings.occupation,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.people_alt_sharp),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (BuildContext context) {
                        return attributeValues.map((String attributeValue) {
                          return PopupMenuItem<String>(
                            value: attributeValue,
                            child: Text(attributeValue),
                          );
                        }).toList();
                      },
                      onSelected: (String selectedValue) {
                        setState(() {
                          selectedAttributeValue = selectedValue;
                        });
                      },
                    ),
                  ),
                  enableInteractiveSelection: false,
                onTap: (){
                  // When tapped, remove the focus to hide the keyboard
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                ),

              SizedBox(height: 20),
              TextField(
                  controller: TextEditingController(text: selectedState),
                  decoration: InputDecoration(
                    labelText: AppStrings.state,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (BuildContext context) {
                        return stateNames.map((String state) {
                          return PopupMenuItem<String>(
                            value: stateNamesAndCodes[state], // Pass the state code
                            child: Text(state),
                          );
                        }).toList();
                      },
                      onSelected: (String selectedValue) {
                        setState(() {
                          selectedStateCode = selectedValue; // Update the selected state code
                          selectedState = stateNames.firstWhere((state) => stateNamesAndCodes[state] == selectedValue,
                              orElse: () => ""); // Update the selected state name
                          // Call the method to get the district list for the selected state code
                          print(selectedValue);
                          getDistrictListService(selectedValue);

                        });
                      },
                    ),
                  ),
                  enableInteractiveSelection: false,
                onTap: (){
                  // When tapped, remove the focus to hide the keyboard
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                ),

            ],
          ),
          SizedBox(height: 20),
          ResponsiveWidgetBuilder.isDesktop(context)
              ? Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: selectedDistrict),
                  decoration: InputDecoration(
                    labelText: AppStrings.district,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (BuildContext context) {
                        return districtNames.map((String districtValue) {
                          return PopupMenuItem<String>(
                            value: districtValue,
                            child: Text(districtValue),
                          );
                        }).toList();
                      },
                      onSelected: (String selectedValue) {
                        int selectedIndex = districtNames.indexOf(selectedValue);
                        String selectedDistrictId = districtIds[selectedIndex];

                        setState(() {
                          selectedDistrict = selectedValue;
                          selectedDistrictId = selectedDistrictId;
                        });
                        print(selectedDistrictId);

                        // Call the method to get the taluk list for the selected districtId
                        getTalukListService(selectedDistrictId);
                      },
                    ),
                  ),
                  enableInteractiveSelection: false,
                  onTap: (){
                    // When tapped, remove the focus to hide the keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: selectedTaluk),
                  decoration: InputDecoration(
                    labelText: AppStrings.taluk,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (BuildContext context) {
                        return talukNames.map((String talukValue) {
                          return PopupMenuItem<String>(
                            value: talukValue,
                            child: Text(talukValue),
                          );
                        }).toList();
                      },
                      onSelected: (String selectedValue) {
                        setState(() {
                          selectedTaluk = selectedValue;
                        });
                      },
                    ),
                  ),
                  enableInteractiveSelection: false,
                  onTap: (){
                    // When tapped, remove the focus to hide the keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
            ],
          )
              : Column(
            children: [
              TextField(
                controller: TextEditingController(text: selectedDistrict),
                decoration: InputDecoration(
                  labelText: AppStrings.district,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.location_on),
                  suffixIcon: PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return districtNames.map((String districtValue) {
                        return PopupMenuItem<String>(
                          value: districtValue,
                          child: Text(districtValue),
                        );
                      }).toList();
                    },
                    onSelected: (String selectedValue) {
                      int selectedIndex = districtNames.indexOf(selectedValue);
                      String selectedDistrictId = districtIds[selectedIndex];

                      setState(() {
                        selectedDistrict = selectedValue;
                        selectedDistrictId = selectedDistrictId;
                      });
                      print(selectedDistrictId);

                      // Call the method to get the taluk list for the selected districtId
                      getTalukListService(selectedDistrictId);
                    },
                  ),
                ),
                enableInteractiveSelection: false,
                onTap: (){
                  // When tapped, remove the focus to hide the keyboard
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: selectedTaluk),
                decoration: InputDecoration(
                  labelText: AppStrings.taluk,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.location_on),
                  suffixIcon: PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return talukNames.map((String talukValue) {
                        return PopupMenuItem<String>(
                          value: talukValue,
                          child: Text(talukValue),
                        );
                      }).toList();
                    },
                    onSelected: (String selectedValue) {
                      setState(() {
                        selectedTaluk = selectedValue;
                      });
                    },
                  ),
                ),
                enableInteractiveSelection: false,
                onTap: (){
                  // When tapped, remove the focus to hide the keyboard
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                  child: CustomTextField(
                controller: mobileNumberJLG,
                labelText: 'Enter Mobile Number',
                suffixIcon: Icons.phone,
                    focusNode: mobileNumberFocusNode,
                keyboardType: TextInputType.phone,

              )),
              SizedBox(width: 20),

              Expanded(
                  child:ElevatedButton(onPressed: () {
                    var mobile = mobileNumberJLG.text.toString();
                    getUserBasicInfoAssisted(mobile);


                  }, child: Text("Add"),

                  ) )
            ],
          ),
          SizedBox(height: 20),
          yourContentWidgetVariable ?? Container(),
          SizedBox(height: 20),
          CustomButton(
            text: 'Submit',
            onPressed: () {
              if(groupName.text.isEmpty){
                setState(() {

                  groupNameFocusNode.requestFocus();
                });
              } else if (selectedAttributeValue.isEmpty) {
                setState(() {
                  // Set an error for selectedAttributeValue and focus on the field
                 // Clear the existing value
                  selectedAttributeValueFocusNode.requestFocus();
                });
              }
              else {
    // groupName and selectedAttributeValue are valid, show the custom dialog
                Widget content = SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                     children: [
                       Row(
                         children: [
                           Icon(Icons.preview),
                           Text('JLG Group Preview:',style: (TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                          
                         ],
                       ),
                       Container(
                         margin: EdgeInsets.only(top: 5.0, bottom: 10.0), // Adjust the margin as needed
                         height: 1.0,
                         color: Colors.black,
                       ),
                       Row(
                         children: [
                           Text('Group Names:',style: (TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                           Text(groupName.text.toString()),
                         ],
                       ),
                       Divider(
                         color: Colors.black, // Customize the color of the divider
                         thickness: 2, // Customize the thickness of the divider
                       ),
                       Row(
                         children: [
                           Text('Group Description:',style: (TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                           Text(groupDescription.text.toString()),
                         ],
                       ),
                       Divider(
                         color: Colors.black, // Customize the color of the divider
                         thickness: 2, // Customize the thickness of the divider
                       ),

                       SizedBox(height: 10),
                       Row(
                         children: [
                           Text('Group Occupation:',style: (TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                           Text(selectedAttributeValue),
                         ],
                       ),
                       Divider(
                         color: Colors.black, // Customize the color of the divider
                         thickness: 2, // Customize the thickness of the divider
                       ),
                       Row(
                         children: [
                           Text('State:',style: (TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                           Text(selectedState),
                         ],
                       ),
                       Divider(
                         color: Colors.black, // Customize the color of the divider
                         thickness: 2, // Customize the thickness of the divider
                       ),
                       Row(
                         children: [
                           Text('District:',style: (TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                           Text(selectedDistrict),
                         ],
                       ),
                       Divider(
                         color: Colors.black, // Customize the color of the divider
                         thickness: 2, // Customize the thickness of the divider
                       ),
                       Row(
                         children: [
                           Text('Taluk:',style: (TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                           Text(selectedTaluk),
                         ],
                       ),
                       Divider(
                         color: Colors.black, // Customize the color of the divider
                         thickness: 2, // Customize the thickness of the divider
                       ),
                       Text('Group Members:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                       yourContentWidgetVariable!,
                       CustomButton(text:"Submit", onPressed: (){
                         jlgGroupRegistrationService();

                       })

                  ],
               ),
                );

              }
               },

            color: Colors.lightBlue,
          ),
        ],
      ),
    );
  }

  void getInfo() async {
    try {
      // Prepare request data
      Map<String, dynamic> requestData = {
        "groupnames": ["JLG"],
      };

      // Make the API request
      Map<String, dynamic> response = await JLGApiService().makeApiRequest(
        ApiConstants.fetchData,
        requestData: requestData,
        requiresAccessToken: true,
        httpMethod: HttpMethod.post,
      );

      // Handle the response as needed
      if (response.containsKey('error')) {
        print('HTTP Status Code: ${response['statusCode']}');
        print('Error Details: ${response['data']}');
      } else {
        print('API Response: $response');

        List<dynamic> jlgListDynamic = response['data']['JLG'];
        List<Map<String, dynamic>> jlgList = List<Map<String, dynamic>>.from(jlgListDynamic);

        for (Map<String, dynamic> jlgItem in jlgList) {
          List<dynamic> attributeOptionsDynamic = jlgItem['attributeoptions'];
          List<Map<String, dynamic>> attributeOptions = List<Map<String, dynamic>>.from(attributeOptionsDynamic);

          for (Map<String, dynamic> attribute in attributeOptions) {
            String attributeValue = attribute['attributevalue'];
            attributeValues.add(attributeValue);
          }

          setState(() {});
        }
      }
    } catch (error) {
      print('Error getting information: $error');
    }
  }

  void getStateListService() async {
    try {
      Map<String, dynamic> response = await JLGApiService().makeApiRequest(
        ApiConstants.stateList,
        requiresAccessToken: true,
        httpMethod: HttpMethod.get,
      );

      if (response.containsKey('error')) {
        // Handle error appropriately
      } else {
        List<dynamic> stateList = response["msgdata"];
        List<StateInfo> stateInfoList =
        stateList.map((stateInfoJson) => StateInfo.fromJson(stateInfoJson)).toList();
        List<String> names = stateInfoList.map((stateInfo) => stateInfo.statename).toList();
        List<String> codes = stateInfoList.map((stateInfo) => stateInfo.statecode).toList();

        // Populate the stateNamesAndCodes map
        stateNamesAndCodes = Map.fromIterables(names, codes);

        GlobalValues().setStateCodes(codes);

        // Update the state names
        setState(() {
          stateNames = names;
          selectedStateCode = ""; // Set selectedStateCode to null initially
        });

        // Fetch district list for the default selected state

      }
    } catch (error) {
      print('Error getting information: $error');
    }
  }


  void getDistrictListService(String? stateCode) async {
    try {
      // Check if stateCode is not null
      if (stateCode != null) {
        // Construct the complete URL with the state code
        String districtListUrl = "usrmgmt/getdistrictlist?statecode=$stateCode";

        // Make the API request using the complete URL
        Map<String, dynamic> response = await JLGApiService().makeApiRequest(
          districtListUrl,
          requiresAccessToken: true,
          httpMethod: HttpMethod.get,
        );

        print('District response: $response');

        if (response.containsKey('msgdata')) {
          Map<String, dynamic> msgData = response['msgdata'];

          if (msgData.containsKey('distlist')) {
            // Store district names in the list using DistrictInfo model
            List<DistrictInfo> districtList = List<DistrictInfo>.from(msgData['distlist'].map((district) => DistrictInfo.fromJson(district)));

            // Extract district names from the list
            districtNames = districtList.map((districtInfo) => districtInfo.districtName).toList();
            districtIds = districtList.map((districtInfo) => districtInfo.districtId).toList();



            // Update the state to trigger a rebuild
            setState(() {});
          }  else {
            print('Error getting district information: No "distlist" key in "msgdata"');
          }
        } else {
          print('Error getting district information: No "msgdata" key in response');
        }
      } else {
        // Handle case when stateCode is null
        print('Error getting district information: State code is null');
      }
    } on DioError catch (dioError) {
      print('Error getting district information: DioError');
      print('DioError message: ${dioError.message}');
      print('DioError response: ${dioError.response}');
      // Handle DioError appropriately
    } catch (error) {
      print('Error getting district information: $error');
      // Handle other errors appropriately
    }
  }
  void getTalukListService(String districtId) async {
    try {
      // Construct the complete URL with the district ID
      String talukListUrl = "usrmgmt/gettaluklist?districtid=$districtId";

      // Make the API request using the complete URL
      dynamic response = await JLGApiService().makeApiRequest(
        talukListUrl,
        requiresAccessToken: true,
        httpMethod: HttpMethod.get,
      );

      print('Raw Taluk response: $response');

      // Parse the JSON string into a map
      try {
        Map<String, dynamic> parsedResponse = json.decode(response);

        print('Parsed Taluk response: $parsedResponse');

        if (parsedResponse.containsKey('msgdata')) {
          Map<String, dynamic> msgData = parsedResponse['msgdata'];

          if (msgData.containsKey('taluklist')) {
            List<Map<String, dynamic>> talukList =
            List<Map<String, dynamic>>.from(msgData['taluklist']);

            // Create a list of TalukInfo objects
            List<TalukInfo> taluks = talukList.map((talukInfo) => TalukInfo.fromJson(talukInfo)).toList();

            // Extract taluk names from the list
            List<String> talukNames = taluks.map((taluk) => taluk.talukName).toList();

            // Update the state to trigger a rebuild
            setState(() {
              this.talukNames = talukNames;
            });

            print('Taluk Names: $talukNames');
          } else {
            print('Error getting taluk information: No "taluklist" key in "msgdata"');
          }
        } else {
          print('Error getting taluk information: No "msgdata" key in response');
        }
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } on DioError catch (dioError) {
      print('Error getting taluk information: DioError');
      print('DioError message: ${dioError.message}');
      print('DioError response: ${dioError.response}');
      // Handle DioError appropriately
    } catch (error) {
      print('Error getting taluk information: $error');
      // Handle other errors appropriately
    }
  }

  void getUserBasicInfoAssisted(String mobile) async {
    Map<String, dynamic> requestData = {
      "userid": mobile,
      "usertype": "3",
    };

    // Make the API request
    Map<String, dynamic> response = await JLGApiService().makeApiRequest(
      ApiConstants.userbasicinfo,
      requestData: requestData,
      requiresAccessToken: true,
      httpMethod: HttpMethod.post,
    );
    print(response);
    if (response.containsKey("msgdata")) {
      Map<String, dynamic> userInfo = response["msgdata"];
      UserBasicInfo userBasicInfo = UserBasicInfo.fromJson(userInfo);
      var occupation = userBasicInfo.occupations;
      var state = userBasicInfo.state;
      var district = userBasicInfo.district;
      var taluk = userBasicInfo.taluk;
      var borrowerName = userBasicInfo.borrowerName;
      var memId = userBasicInfo.mmid;
      GlobalValues.setBorrowerName(borrowerName);
      var kycStatus = userBasicInfo.kycStatus;

      GlobalValues.setKYCStatus(kycStatus);

      String status = (kycStatus == "1") ? "Verified" : "Not verified";

      bool isOccupation = occupation.any((occupation) {
        return occupation == selectedAttributeValue;
      });

      Widget contentWidget;

      if (isOccupation) {
        bool isStateMatch = state == selectedState;
        bool isDistrictMatch = district == selectedDistrict;
        bool isTaluk = taluk == selectedTaluk;
        Widget contentWidget = Text("Not selected");

        if (isOccupation && isStateMatch && isDistrictMatch && isTaluk) {
          contentWidget = Card(
            elevation: 3,
            child: ListTile(
              title: Text(borrowerName),
              subtitle: Text(status),
              trailing: IconButton(
                onPressed: () {
                  deleteCard(contentWidget);

                },
                icon: Icon(Icons.delete),
              ),
            ),
          );
        }
        memberIdList.add(memId);

        // Add the new widget to the list
        mobileWidgets.add(contentWidget);

        // Update the UI to reflect the new list of widgets
        setState(() {
          // Assuming you have a state variable 'yourContentWidgetVariable'
          yourContentWidgetVariable = Column(
            children: mobileWidgets,
          );

          mobileNumberJLG.clear();
        });
      }
      else {
        showAlertDialog(context, "Please Provide Similar Occupation Mobile Number");
      }
    }



  }
  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
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


  void deleteCard(Widget card) {
    // Remove the card from the list
    mobileWidgets.remove(card);

    // Update the UI to reflect the updated list of widgets
    setState(() {
      yourContentWidgetVariable = Column(
          children: mobileWidgets,
      );});
  }

  void jlgGroupRegistrationService() async {
    try {
      Map<String, dynamic> requestData = {
        "groupname": groupName.text,
        "groupdesc": groupDescription.text,
        "memberslist": memberIdList.map((memId) => {"memmid": memId}).toList(),
        "district": selectedDistrict,
        "groupoccupation": selectedAttributeValue,
        "state": selectedState,
        "taluk": selectedTaluk,
      };

      Map<String, dynamic> response = await JLGApiService().makeApiRequest(
        ApiConstants.jlgRegistrationService,
        requestData: requestData,
        requiresAccessToken: true,
        httpMethod: HttpMethod.post,
      );

      print(response);


      // Check HTTP status code
      if (response.containsKey('status') && response['status'] == 'Success') {


        CustomDialogs.showSuccess(context, response['message']);

        // Handle the case where 'groupid' is found
        if (response.containsKey('groupid')) {
          print('Group ID: ${response['groupid']}');
        }
      } else {
        CustomDialogs.showError(context, response['message']);

        // Handle the case where 'groupid' is not found or API call fails
        print('Error: ${response['statusCode']}, ${response['message']}');
      }

    } catch (e) {

      print('Error: $e');
    }
  }


}
