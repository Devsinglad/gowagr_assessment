import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gowagr_assessment/data/services/filters.dart';
import 'package:logger/logger.dart';

import '../../utils/assets/url.dart';

import '../model/public_event_res.dart';
import 'dioClient.dart';

class DashboardService {
  final baseUrl = Gowagr.baseUrl;
  final _logger = Logger();

  Future<PublicEventResponse> fetchEvents({
    String? keyword,
    bool? trending,
    int size = 10,
    int page = 1,
    String? category,
  }) async {
    try {
      final queryParams = EventFilter.buildQueryParams(
        keyword: keyword,
        trending: trending,
        size: size,
        page: page,
        category: category,
      );

      final response = await ApiCall.getInstance().getReq(
        baseUrl,
        params: queryParams,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return PublicEventResponse.fromJson(response.data);
    } on DioException catch (e, s) {
      _logger.e('$e');
      _logger.e('$s');
      rethrow;
    }
  }
}
