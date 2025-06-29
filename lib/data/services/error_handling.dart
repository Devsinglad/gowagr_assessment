import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


void handleDioError(Object e, BuildContext context, {String? errMsg}) {
  if (e is DioException) {
    // Log the error for debugging
    log('DioException: ${e.type} - ${e.message}');
    if (e.response != null) {
      log('Response data: ${e.response?.data}');
      log('Status code: ${e.response?.statusCode}');
    }

    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      customPopUp(
          context,
          'Network is unreachable! Please, check your internet connection and try again.',
          "warning");
    } else if (e.response != null) {
      if (_isInvalidTokenError(e.response!.data)) {
        _handleInvalidToken(context);
        return;
      }

      // Then handle other status code based errors
      if (e.response?.statusCode == 404 ||
          e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 500) {
        final message = _extractErrorMessage(e.response!.data);
        customPopUp(context, message, "warning");
      } else {
        // For any other response error
        final message = _extractErrorMessage(e.response!.data);
        customPopUp(context, errMsg ?? message, "warning");
      }
    } else {
      customPopUp(context, errMsg ?? 'Request failed: ${e.message}', "warning");
    }
  } else {
    // Handle any other type of exception
    log('Unexpected error: $e');
    customPopUp(
        context, 'An unexpected error occurred. Please try again.', "error");
  }
}

/// Helper method to detect invalid token errors from various response formats
bool _isInvalidTokenError(dynamic responseData) {
  final invalidTokenPhrases = ['invalid token', 'invalid auth token'];

  if (responseData is Map) {
    /// Check common error message fields
    final possibleFields = ['message', 'error', 'errorMessage', 'description'];

    for (var field in possibleFields) {
      final value = responseData[field];
      if (value is String) {
        final lowerValue = value.toLowerCase();
        // Check against all invalid token phrases
        for (var phrase in invalidTokenPhrases) {
          if (lowerValue.contains(phrase)) {
            log('Token error detected: $value');
            return true;
          }
        }
      }
    }
  } else if (responseData is String) {
    /// If response is directly a string
    final lowerValue = responseData.toLowerCase();
    for (var phrase in invalidTokenPhrases) {
      if (lowerValue.contains(phrase)) {
        return true;
      }
    }
  }

  return false;
}

/// Handle invalid token by redirecting to login
void _handleInvalidToken(BuildContext context) {
  log('Invalid token detected - redirecting to login');


  customPopUp(context, 'Session has expired, please log in again', "warning");

}

/// Extract error message from response data
String _extractErrorMessage(dynamic responseData) {
  String defaultMessage = "An error occurred";

  if (responseData is Map) {
    final possibleFields = ['message', 'error', 'errorMessage', 'description'];
    for (var field in possibleFields) {
      if (responseData.containsKey(field) && responseData[field] is String) {
        return responseData[field];
      }
    }

    return responseData.toString();
  } else if (responseData is String) {
    return responseData;
  }

  return defaultMessage;
}

void customPopUp(BuildContext context, String message, String type) {
  final overlay = Overlay.of(context);
  final snackBar = Positioned(
    top: MediaQuery.of(context).padding.top + 20.0,
    left: 10.0,
    right: 10.0,
    child: Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: type == "warning" ? const Color(0xFFF3EEF7) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: type == "warning"
                ? const Color(0xff66191D)
                : const Color(0xFF40711B),
          ),
        ),
      ),
    ),
  );

  // Create an OverlayEntry
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => snackBar,
  );

  // Insert the overlay entry into the overlay
  overlay.insert(overlayEntry);

  // Remove the overlay entry after a duration
  Future.delayed(const Duration(seconds: 5), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}
