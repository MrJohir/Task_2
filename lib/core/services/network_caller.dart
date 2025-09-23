import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/logging/logger.dart';

class NetworkCaller {
  static const Duration _timeoutDuration = Duration(seconds: 30);

  static Future<Map<String, dynamic>> getRequest(String url) async {
    try {
      AppLogger.info('Making GET request to: $url');

      final response = await http
          .get(Uri.parse(url), headers: _getHeaders())
          .timeout(_timeoutDuration);

      return _handleResponse(response, url);
    } on SocketException {
      AppLogger.error('No internet connection for GET: $url');
      throw Exception('No internet connection');
    } on http.ClientException catch (e) {
      AppLogger.error('Client error for GET: $url', e);
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected error for GET: $url', e);
      throw Exception('An unexpected error occurred');
    }
  }


  static Future<List<dynamic>> getListRequest(String url) async {
    try {
      AppLogger.info('Making GET list request to: $url');

      final response = await http
          .get(Uri.parse(url), headers: _getHeaders())
          .timeout(_timeoutDuration);

      final result = _handleResponse(response, url);

      if (result['data'] is List) {
        return result['data'] as List<dynamic>;
      } else {
        // If the response is directly a list
        return json.decode(response.body) as List<dynamic>;
      }
    } on SocketException {
      AppLogger.error('No internet connection for GET list: $url');
      throw Exception('No internet connection');
    } on http.ClientException catch (e) {
      AppLogger.error('Client error for GET list: $url', e);
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected error for GET list: $url', e);
      throw Exception('An unexpected error occurred');
    }
  }

  static Future<Map<String, dynamic>> postRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      AppLogger.info('Making POST request to: $url');
      AppLogger.debug('POST body: $body');

      final response = await http
          .post(Uri.parse(url), headers: _getHeaders(), body: json.encode(body))
          .timeout(_timeoutDuration);

      return _handleResponse(response, url);
    } on SocketException {
      AppLogger.error('No internet connection for POST: $url');
      throw Exception('No internet connection');
    } on http.ClientException catch (e) {
      AppLogger.error('Client error for POST: $url', e);
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      AppLogger.error('Unexpected error for POST: $url', e);
      throw Exception('An unexpected error occurred');
    }
  }

  /// Get default headers for API requests
  static Map<String, String> _getHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }

  static Map<String, dynamic> _handleResponse(
    http.Response response,
    String url,
  ) {
    AppLogger.info('Response status code: ${response.statusCode} for $url');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final responseData = json.decode(response.body);
        AppLogger.debug('Response data: $responseData');

        // If response is a list, wrap it in a map
        if (responseData is List) {
          return {'data': responseData};
        }

        // If response is already a map, return it
        if (responseData is Map<String, dynamic>) {
          return responseData;
        }

        // For other types, wrap in a map
        return {'data': responseData};
      } catch (e) {
        AppLogger.error('Failed to parse response JSON for $url', e);
        throw Exception('Invalid response format');
      }
    } else {
      String errorMessage = _getErrorMessage(response.statusCode);
      AppLogger.error(
        'HTTP error ${response.statusCode} for $url: $errorMessage',
      );
      AppLogger.error('Response body: ${response.body}');
      throw Exception(errorMessage);
    }
  }

  static String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please check your credentials.';
      case 403:
        return 'Forbidden. You don\'t have permission to access this resource.';
      case 404:
        return 'Resource not found.';
      case 408:
        return 'Request timeout. Please try again.';
      case 429:
        return 'Too many requests. Please wait a moment and try again.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      case 504:
        return 'Gateway timeout. Please try again later.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }
}
