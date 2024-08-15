import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options.baseUrl = 'https://free.currencyconverterapi.com/api/v6';
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(endpoint, queryParameters: queryParameters);
  }
}