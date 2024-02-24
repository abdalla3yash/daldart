import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../resources/resources.dart';

const String _baseURL = "https://api.reddit.com/r/FlutterDev/";

class ApiClient {
  final Dio _dio;
  final Interceptor _prettyDioLogger;

  ApiClient(this._dio, this._prettyDioLogger) {
    final BaseOptions baseOptions = BaseOptions(
        baseUrl: _baseURL,
        receiveDataWhenStatusError: true,
        connectTimeout: Time.t30s,
        receiveTimeout: Time.t30s,
        sendTimeout: Time.t30s);
    _dio.options = baseOptions;
    if (kDebugMode) _dio.interceptors.add(_prettyDioLogger);
  }

  Future<Response> get({required String url, Map<String, dynamic>? queryParameters}) async => await _dio.get(url, queryParameters: queryParameters);
}
