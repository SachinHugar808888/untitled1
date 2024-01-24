
import 'package:shared_preferences/shared_preferences.dart';

import 'aes_helper.dart';

class SharedPreferencesHelper {
  static const String memidKey = 'memid';
  static const String accessTokenKey = 'accessToken';
  

  // Save memid to SharedPreferences
  static Future<void> saveMemid(int memid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(memidKey, memid);
  }

  // Read memid from SharedPreferences
  static Future<int> getMemid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(memidKey) ?? 0;
  }

  // Save accessToken to SharedPreferences
  static Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
  }

  // Read accessToken from SharedPreferences
  static Future<String> getAccessToken() async {
    // Implement your logic to get the access token from SharedPreferences
    // Example: return SharedPreferences.getInstance().then((prefs) => prefs.getString(accessTokenKey) ?? '');
    return SharedPreferences.getInstance().then((prefs) => prefs.getString(accessTokenKey) ?? '');
  }
  static Future<void> setUserName(String userName)async {
    final encryptedUserName = AESHelper.encryptMsg(userName);


  }


}
