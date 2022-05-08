import 'package:dio/dio.dart';

import '../constants/strings.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: BASE_URL, receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String url,
      required String lang,
      Map<String, dynamic>? query,
      String token = ''}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      required String lang,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String token = ''}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {required String url,
      required String lang,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String token = ''}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
}
