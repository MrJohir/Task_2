import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Storage service for local data persistence
/// Handles storing and retrieving data locally using GetStorage
class StorageService extends GetxService {
  /// Keys for storing data
  static const String _keyProducts = 'cached_products';
  static const String _keyCategories = 'cached_categories';
  static const String _keyLastFetchTime = 'last_fetch_time';

  /// Cache expiry duration (1 hour)
  static const Duration cacheExpiry = Duration(hours: 1);

  /// Save products to local storage
  /// [products] - List of product data to store
  Future<void> saveProducts(List<Map<String, dynamic>> products) async {
    try {
      await Get.find<GetStorage>().write(_keyProducts, products);
      await Get.find<GetStorage>().write(
        _keyLastFetchTime,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      // Silently handle storage errors
    }
  }

  /// Get cached products from local storage
  /// Returns cached products if available and not expired, null otherwise
  List<Map<String, dynamic>>? getCachedProducts() {
    try {
      final lastFetchTime = Get.find<GetStorage>().read<int>(_keyLastFetchTime);

      if (lastFetchTime != null) {
        final fetchDateTime = DateTime.fromMillisecondsSinceEpoch(
          lastFetchTime,
        );
        final isExpired =
            DateTime.now().difference(fetchDateTime) > cacheExpiry;

        if (!isExpired) {
          final products = Get.find<GetStorage>().read<List>(_keyProducts);
          return products?.cast<Map<String, dynamic>>();
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Save categories to local storage
  /// [categories] - List of category data to store
  Future<void> saveCategories(List<String> categories) async {
    try {
      await Get.find<GetStorage>().write(_keyCategories, categories);
    } catch (e) {
      // Silently handle storage errors
    }
  }

  /// Get cached categories from local storage
  /// Returns cached categories if available, null otherwise
  List<String>? getCachedCategories() {
    try {
      final categories = Get.find<GetStorage>().read<List>(_keyCategories);
      return categories?.cast<String>();
    } catch (e) {
      return null;
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    try {
      await Get.find<GetStorage>().remove(_keyProducts);
      await Get.find<GetStorage>().remove(_keyCategories);
      await Get.find<GetStorage>().remove(_keyLastFetchTime);
    } catch (e) {
      // Silently handle storage errors
    }
  }

  /// Check if cache is expired
  bool isCacheExpired() {
    try {
      final lastFetchTime = Get.find<GetStorage>().read<int>(_keyLastFetchTime);

      if (lastFetchTime != null) {
        final fetchDateTime = DateTime.fromMillisecondsSinceEpoch(
          lastFetchTime,
        );
        return DateTime.now().difference(fetchDateTime) > cacheExpiry;
      }

      return true;
    } catch (e) {
      return true;
    }
  }
}
