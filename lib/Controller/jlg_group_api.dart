import 'package:untitled1/Network/shared_preferences.dart';

import '../util/ApiConstants.dart';
import 'package:dio/dio.dart';


class JLGApiService {
  final Dio _dio = Dio();

  Future<dynamic> makeApiRequest(
      String endpoint, {
        Map<String, dynamic>? requestData,
        bool requiresAccessToken = true,
        HttpMethod httpMethod = HttpMethod.post,

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
      String url = '${ApiConstants.baseUrl}$endpoint';
      print(url);
      print('Request Data: $requestData');

      Response response;
      switch (httpMethod) {
        case HttpMethod.post:
          response = await _dio.post(
            '${ApiConstants.baseUrl}$endpoint',
            data: requestData,
          );
          break;
        case HttpMethod.get:
          response = await _dio.get(
            '${ApiConstants.baseUrl}$endpoint',
          );
          break;
      }

      dynamic responseData = response.data;

      // Check if responseData is a String (JSON string) or a Map
      if (responseData is String) {
        return responseData;
      } else if (responseData is Map<String, dynamic>) {
        return responseData;
      } else {
        // Handle other data types if necessary
        throw Exception("Unexpected response data type");
      }
    } catch (error) {
      if (error is DioError) {
        return {
          'error': 'DioError',
          'statusCode': error.response?.statusCode,
          'data': error.response?.data,
        };
      }
      throw error;
    }
  }


  Future<String> getAccessToken() async {
    // Implement your logic to get the access token from SharedPreferences
    // Example: return SharedPreferencesHelper.getAccessToken();
    return SharedPreferencesHelper.getAccessToken();
  }
}



enum HttpMethod { post, get }
