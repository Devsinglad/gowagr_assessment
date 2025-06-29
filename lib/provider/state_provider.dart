import 'package:flutter/material.dart';

import '../data/model/view_state_enums.dart';

mixin StateViewModel on ChangeNotifier {
  ViewState _state = ViewState.idle;
  String? _errorMessage;

  ViewState get state => _state;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == ViewState.loading;

  bool get isError => _state == ViewState.error;

  bool get isSuccess => _state == ViewState.success;

  bool get isIdle => _state == ViewState.idle;

  void setState(ViewState newState) {
    _state = newState;
    if (newState != ViewState.error) _errorMessage = null;
    notifyListeners();
  }

  void setError(String error) {
    _errorMessage = error;
    setState(ViewState.error);
  }
}
