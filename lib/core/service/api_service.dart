import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiEndPoints.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (kDebugMode) {
            print('--> ${options.method} ${options.uri}');
            print('Headers: ${options.headers}');
            print('Body: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('<-- ${response.statusCode} ${response.requestOptions.uri}');
            print('Response: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('<-- ERROR: ${e.message}');
            if (e.response != null) {
              print('Error Status: ${e.response?.statusCode}');
              print('Error Data: ${e.response?.data}');
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Handle and format error message from Response
  String _handleError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final data = e.response?.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'].toString();
      }
      return 'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
    }
    return e.message ?? 'Something went wrong';
  }

  // GET Method with Query Parameters
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      final errorMsg = _handleError(e);
      if (kDebugMode) print('GET Error Message: $errorMsg');
      throw Exception(errorMsg);
    }
  }

  // POST Method with Request Body
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      final errorMsg = _handleError(e);
      if (kDebugMode) print('POST Error Message: $errorMsg');
      throw Exception(errorMsg);
    }
  }

  // PUT Method with Request Body
  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      final errorMsg = _handleError(e);
      if (kDebugMode) print('PUT Error Message: $errorMsg');
      throw Exception(errorMsg);
    }
  }

  // DELETE Method with optional Request Body
  Future<Response> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } on DioException catch (e) {
      final errorMsg = _handleError(e);
      if (kDebugMode) print('DELETE Error Message: $errorMsg');
      throw Exception(errorMsg);
    }
  }
}
