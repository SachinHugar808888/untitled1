import 'dart:convert';

import 'package:untitled1/Controller/key_pair_generator.dart';
import 'package:untitled1/Network/shared_preferences.dart';
import '../util/ApiConstants.dart';
import 'package:dio/dio.dart';
import 'global_class.dart';
import 'key_pair_generator_mobile.dart';

class JLGApiService {
  final Dio _dio = Dio();
  var secretKey = GlobalValues.getSecretKey();
  var referenceNo = GlobalValues.getReferenceNo();

  Future<dynamic> makeApiRequest(
      String endpoint, {
        Map<String, dynamic>? requestData,
        FormData? formData,
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

      Response response;

      switch (httpMethod) {
        case HttpMethod.post:
          response = await _dio.post(
            url,
            data: formData ?? requestData,
          );
          break;

        case HttpMethod.get:
          response = await _dio.get(
            url,
          );
          break;
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        return responseData;
      } else if (responseData is Map<String, dynamic>) {
        return responseData;
      } else {
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
    return SharedPreferencesHelper.getAccessToken();
  }
}

enum HttpMethod { post, get }



