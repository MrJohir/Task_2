import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../constants/app_texts.dart';

/// Application helper functions
/// Contains utility methods used throughout the app
class AppHelper {
  /// Show loading indicator
  static void showLoading([String? message]) {
    EasyLoading.show(
      status: message ?? AppTexts.loading,
      maskType: EasyLoadingMaskType.black,
    );
  }

  /// Hide loading indicator
  static void hideLoading() {
    EasyLoading.dismiss();
  }

  /// Show success message
  /// [message] - Success message to display
  static void showSuccess(String message) {
    EasyLoading.showSuccess(message);
  }

  /// Show error message
  /// [message] - Error message to display
  static void showError(String message) {
    EasyLoading.showError(message);
  }

  /// Show info message
  /// [message] - Info message to display
  static void showInfo(String message) {
    EasyLoading.showInfo(message);
  }

  /// Format price with currency symbol
  /// [price] - Price value to format
  /// [currencySymbol] - Currency symbol (default: $)
  /// Returns formatted price string
  static String formatPrice(double price, [String currencySymbol = '\$']) {
    return '$currencySymbol${price.toStringAsFixed(2)}';
  }

  /// Format rating display
  /// [rating] - Rating value
  /// [maxRating] - Maximum rating (default: 5)
  /// Returns formatted rating string
  static String formatRating(double rating, [int maxRating = 5]) {
    return '${rating.toStringAsFixed(1)}/$maxRating';
  }

  /// Capitalize first letter of string
  /// [text] - String to capitalize
  /// Returns capitalized string
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Truncate text to specified length
  /// [text] - Text to truncate
  /// [maxLength] - Maximum length
  /// [ellipsis] - Ellipsis string (default: ...)
  /// Returns truncated text
  static String truncateText(
    String text,
    int maxLength, [
    String ellipsis = '...',
  ]) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$ellipsis';
  }

  /// Check if string is valid email
  /// [email] - Email string to validate
  /// Returns true if valid email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Check if string is not null or empty
  /// [value] - String to check
  /// Returns true if string has content
  static bool isNotNullOrEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Get image error placeholder
  /// Returns default error widget for failed image loads
  static Widget getImageErrorPlaceholder({
    double? width,
    double? height,
    IconData icon = Icons.image_not_supported,
  }) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: Icon(icon, color: Colors.grey[600], size: 32),
    );
  }

  /// Get image loading placeholder
  /// Returns loading widget for image loading states
  static Widget getImageLoadingPlaceholder({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  /// Debounce function calls
  /// [milliseconds] - Delay in milliseconds
  /// [action] - Function to execute
  static Timer? _debounceTimer;

  static void debounce(int milliseconds, Function action) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: milliseconds), () {
      action();
    });
  }
}
