class GlobalValues {
  static String _borrowerName = "";
  static String  _referenceNo = "";
  static bool _encrypted = false;
  static String _secretKey = "";
  static String _mobile = "";

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
  static void setSecretKey(String secretKey) {
    _secretKey = secretKey;
  }

  static String getSecretKey() {
    return _secretKey;
  }
  static void setMobile(String mobile) {
    _mobile = mobile;
  }

  static String getMobile() {
    return _mobile;
  }


  static void setEncrypted(bool encrypted) {
    _encrypted = encrypted;
  }

  static bool getEncrypted() {
    return _encrypted;
  }
  static void setReferenceNo(String referenceNo) {
    _referenceNo = referenceNo;
  }

  static String getReferenceNo() {
    return _referenceNo;
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
