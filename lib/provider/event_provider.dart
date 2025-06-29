import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gowagr_assessment/data/local_data/repository.dart';
import 'package:gowagr_assessment/data/model/public_event_res.dart';
import 'package:gowagr_assessment/data/model/view_state_enums.dart';
import 'package:gowagr_assessment/data/services/dashBoard_service.dart';
import 'package:gowagr_assessment/data/services/error_handling.dart';
import 'package:gowagr_assessment/provider/state_provider.dart';

import '../data/model/category_model.dart';

class ExploreViewModel extends ChangeNotifier with StateViewModel {
  final _apiService = DashboardService();

  final List<CategoryModel> categories = [
    CategoryModel(label: 'Trending', iconData: Icons.trending_up),
    CategoryModel(label: 'Watchlist', iconData: Icons.bookmark_border),
    CategoryModel(label: 'Entertainment  🎶'),
    CategoryModel(label: 'Sports  ⚽️'),
  ];

  List<Event> _events = [];
  String _searchQuery = '';
  String _selectedCategory = 'Trending';
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetchingMore = false;

  List<Event> get events => _events;

  String get searchQuery => _searchQuery;

  String get selectedCategory => _selectedCategory;

  bool get hasMore => _hasMore;

  bool get isFetchingMore => _isFetchingMore;

  Future<void> initialize(BuildContext context) async {
    _currentPage = 1;
    _events.clear();
    await loadEvents(context, reset: true);
  }

  Future<void> loadEvents(BuildContext context, {bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _hasMore = true;
      _events.clear();
      setState(ViewState.loading);
    } else {
      _isFetchingMore = true;
      notifyListeners();
    }

    try {
      final response = await _apiService.fetchEvents(
        keyword: _searchQuery.isEmpty ? null : _searchQuery,
        trending: _selectedCategory == 'Trending' ? true : null,
        category: _selectedCategory != 'Trending'
            ? _selectedCategory.toUpperCase()
            : null,
        page: _currentPage,
        size: 10,
      );

      if (reset) {
        _events.clear();
        setState(ViewState.success);
      }

      if (response.events.isEmpty && reset) {
        _events.clear();
        _hasMore = false;
      } else {
        _events.addAll(response.events);
        _hasMore = _currentPage < response.pagination.lastPage;

        if (reset) {
          await Repository.getInstance()!.cacheResponse(
            json.encode(response.toJson()),
          );
        }

        _currentPage++;
      }

      _isFetchingMore = false;
      notifyListeners();
    } on DioException catch (e) {
      if (reset) {
        final cached = await Repository.getInstance()!.getCachedEvents();
        if (cached != null) {
          _events = cached.events;
          _hasMore = _currentPage < cached.pagination.lastPage;
          setState(ViewState.success);
        } else {
          setState(ViewState.error);
        }
      }

      _isFetchingMore = false;
      notifyListeners();
      handleDioError(e, context);
    }
  }

  Future<void> loadMoreEvents(BuildContext context) async {
    if (_hasMore && !_isFetchingMore) {
      await loadEvents(context);
    }
  }

  Future<void> searchEvents(String query, BuildContext context) async {
    if (_searchQuery != query) {
      _searchQuery = query;
      _currentPage = 1;
      _events.clear();
      await loadEvents(context, reset: true);
    }
  }

  Future<void> changeCategory(String category, BuildContext context) async {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      _searchQuery = '';
      _currentPage = 1;
      _events.clear();
      await loadEvents(context, reset: true);
    }
  }

  Future<void> refresh(BuildContext context) async {
    _currentPage = 1;
    _events.clear();
    await loadEvents(context, reset: true);
  }
}
