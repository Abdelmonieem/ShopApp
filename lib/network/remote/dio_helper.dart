import 'package:dio/dio.dart';
import 'package:shopapp/network/local/shared_preference.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
      headers: {'Content-Type': 'application/json', 'lang': 'ar'},
    ));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String? lang,
      String? token}) async {
    dio.options.headers = {
      'lang': '$lang',
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String? lang,
    String? token,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': '$lang',
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> updateData({
    required String url,
    required Map<String, dynamic> data,
    String? lang,
    required String? token,
  }) async {
    dio.options.headers = {
      'lang': '$lang',
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };
    return await dio.put(
      url,
      data: data,
    );
  }
}
