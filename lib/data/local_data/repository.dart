import 'dart:convert';

import 'package:gowagr_assessment/data/model/public_event_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static Repository? _instance;
  static late SharedPreferences _pref;

  Repository._internal();

  static init() async {
    _instance = Repository._internal();
    _pref = await SharedPreferences.getInstance();
  }

  static Repository? getInstance() {
    return _instance;
  }

  Future<void> cacheResponse(String jsonString) async {
    await _pref.setString('cached_events', jsonString);
  }

  Future<PublicEventResponse?> getCachedEvents() async {
    final cached = _pref.getString('cached_events');
    if (cached != null) {
      return PublicEventResponse.fromJson(json.decode(cached));
    }
    return null;
  }
}
