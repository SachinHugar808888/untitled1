import 'package:untitled1/Network/shared_preferences.dart';

import '../util/ApiConstants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String base64Mobile, String base64Password) async {
    try {
      Map<String, dynamic> requestData = {
        'username': base64Mobile,
        'userpassword': base64Password,
      };

      Response response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}',
        data: requestData,
      );

      // Parse the response data
      Map<String, dynamic> responseData = response.data;

      // Extract the 'data' field from the response
      Map<String, dynamic> userData = responseData['data'];

      return userData;
    } catch (error) {
      throw error;
    }
  }
 /* Future<Map<String, dynamic>> makeApiRequest(
      String endpoint,
      Map<String, dynamic> requestData, {
        bool requiresAccessToken = true,
      }) async {
    try {
      if (requiresAccessToken) {
        String accessToken = await getAccessToken();
        if (accessToken.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer $accessToken';
        } else {
          throw Exception("Access token is not available");
        }
      }

      Response response = await _dio.post(
        '${ApiConstants.baseUrl}$endpoint',
        data: requestData,
      );

      Map<String, dynamic> responseData = response.data;
      return responseData;
    } catch (error) {
      if (error is DioError) {
        return {'error': 'DioError', 'statusCode': error.response?.statusCode, 'data': error.response?.data};
      }
      throw error;
    }
  }

  Future<String> getAccessToken() async {
    // Implement your logic to get the access token from SharedPreferences
    // Example: return SharedPreferencesHelper.getAccessToken();
    return SharedPreferencesHelper.getAccessToken();
  }*/
}
