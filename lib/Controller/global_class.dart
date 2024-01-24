class GlobalValues {
  static String _borrowerName = "";
  static String userName = "";
  static final GlobalValues _instance = GlobalValues._internal();
  GlobalValues._internal();
  static bool userLoggedIn = false;
  static bool kycStatus = false;


  factory GlobalValues() => _instance;

  List<String>? _stateCodes;

  void setStateCodes(List<String> codes) {
    _stateCodes = codes;
  }

  List<String>? getStateCodes() {
    return _stateCodes;
  }
  static void setBorrowerName(String name) {
    _borrowerName = name;
  }

  static String getBorrowerName() {
    return _borrowerName;
  }
  static void setKYCStatus(String name) {
    _borrowerName = name;
  }
  static String getUserName() {
    return userName;
  }
  static void setUserName(String name) {
    userName = name;
  }

  static String getKYCStatus() {
    return _borrowerName;
  }
  static void setUserLogged(bool value){
    userLoggedIn = value;
  }
  static bool getUserLogged(){
    return userLoggedIn;
  }




}
