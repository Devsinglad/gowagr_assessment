import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class ApiCall {
  late Dio _dio;

  ApiCall._internal([String? authToken]) {
    _dio = Dio();

    _dio.options.baseUrl = '';
    _dio.options.connectTimeout = const Duration(seconds: 1500);
    _dio.options.receiveTimeout = const Duration(seconds: 1500);
    _dio.options.responseType = ResponseType.json;
    _dio.options.contentType = "";
    _dio.options.headers = {
      'Content-Type': 'application/json; charset=utf-8',
      "Accept": "*/*",
      "Authorization": "Bearer ${authToken ?? ''}",
    };
    if (!kReleaseMode) {
      _dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: !kReleaseMode,
        responseHeader: true,
        responseBody: !kReleaseMode,
      ));
    }
  }

  static ApiCall getInstance() {
    return ApiCall._internal();
  }

  void setToken(String? authToken) {
    _dio.options.headers['Authorization'] =
        'Bearer';
  }

  Future<Response> postReq(
    String url, {
    Object? data,
    Map<String, dynamic>? params,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data ?? formData,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patchReq(
    String url, {
    Object? data,
    Map<String, dynamic>? params,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data ?? formData,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getReq(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putReq(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteReq(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
