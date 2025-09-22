import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers/app_helper.dart';
import '../../../core/utils/logging/logger.dart';
import '../../../core/utils/constants/app_texts.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

/// Product controller for managing product-related state and operations
/// Uses GetX for state management with reactive programming
class ProductController extends GetxController {
  /// Reactive variables for state management
  final RxList<Product> _allProducts = <Product>[].obs;
  final RxList<Product> _filteredProducts = <Product>[].obs;
  final RxList<String> _categories = <String>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isRefreshing = false.obs;
  final RxString _searchQuery = ''.obs;
  final RxString _selectedCategory = ''.obs;
  final RxString _errorMessage = ''.obs;

  /// Search text controller for search field
  final TextEditingController searchController = TextEditingController();

  /// Timer for search debouncing
  Timer? _searchDebounceTimer;

  /// Getters for accessing reactive variables
  List<Product> get allProducts => _allProducts;
  List<Product> get filteredProducts => _filteredProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading.value;
  bool get isRefreshing => _isRefreshing.value;
  String get searchQuery => _searchQuery.value;
  String get selectedCategory => _selectedCategory.value;
  String get errorMessage => _errorMessage.value;
  bool get hasError => _errorMessage.value.isNotEmpty;
  bool get hasProducts => _filteredProducts.isNotEmpty;
  bool get isEmpty => _filteredProducts.isEmpty && !_isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Load initial data when controller is initialized
    loadInitialData();

    // Listen to search text changes with debouncing
    searchController.addListener(_onSearchTextChanged);
  }

  @override
  void onClose() {
    // Clean up resources
    searchController.dispose();
    _searchDebounceTimer?.cancel();
    super.onClose();
  }

  /// Load initial data (products and categories)
  /// Shows loading indicator and handles errors appropriately
  Future<void> loadInitialData() async {
    try {
      _setLoading(true);
      _clearError();

      AppLogger.info('Loading initial product data');

      // Load products and categories concurrently
      await Future.wait([_loadProducts(), _loadCategories()]);

      AppLogger.info('Initial data loaded successfully');
    } catch (e) {
      AppLogger.error('Failed to load initial data', e);
      _setError('Failed to load data. Please try again.');
      AppHelper.showError(AppTexts.errorOccurred);
    } finally {
      _setLoading(false);
    }
  }

  /// Refresh products manually
  Future<void> refreshProducts() async {
    try {
      _setLoading(true);
      _setRefreshing(true);

      // Add delay to showcase shimmer effect
      await Future.delayed(
        const Duration(milliseconds: 1200),
      ); // Reduced for smoother experience

      await Future.wait([_loadProducts(), _loadCategories()]);

      AppLogger.info('Product data refreshed successfully');
    } catch (e) {
      AppLogger.error('Failed to refresh products', e);
      _setError('Failed to refresh data. Please try again.');
      AppHelper.showError(AppTexts.errorOccurred);
    } finally {
      _setLoading(false);
      _setRefreshing(false);
    }
  }

  /// Search products by query string
  /// [query] - Search query string
  /// Applies debouncing to prevent excessive API calls
  void searchProducts(String query) async {
    _searchQuery.value = query;

    // Cancel previous timer
    _searchDebounceTimer?.cancel();

    // Show shimmer effect for search
    if (query.isNotEmpty && query != _searchQuery.value) {
      _setLoading(true);
    }

    // Start new timer for debouncing
    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // Add delay to showcase shimmer effect for search
      if (query.isNotEmpty) {
        await Future.delayed(
          const Duration(milliseconds: 800),
        ); // Slightly increased for smoother effect
      }

      _applyFilters();
      _setLoading(false);
    });
  }

  /// Filter products by category
  /// [category] - Category to filter by (empty string for all categories)
  void filterByCategory(String category) async {
    // Show shimmer effect during category filtering
    _setLoading(true);
    _selectedCategory.value = category;

    // Add delay to showcase shimmer effect
    await Future.delayed(
      const Duration(milliseconds: 1000),
    ); // Increased for smoother effect

    _applyFilters();
    _setLoading(false);
  }

  /// Clear all filters and search
  /// Resets to show all products
  void clearFilters() async {
    // Show shimmer effect when clearing filters
    _setLoading(true);

    _searchQuery.value = '';
    _selectedCategory.value = '';
    searchController.clear();

    // Add delay to showcase shimmer effect
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Increased for smoother effect

    _applyFilters();
    _setLoading(false);
  }

  /// Get category display name for dropdown
  /// [category] - Category string
  /// Returns formatted category name or "All Categories" for empty string
  String getCategoryDisplayName(String category) {
    if (category.isEmpty) return AppTexts.allCategories;
    return category
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  /// Load products from API
  /// Private method for fetching product data
  Future<void> _loadProducts() async {
    try {
      final List<Product> products = await ProductService.getAllProducts();
      _allProducts.assignAll(products);
      _applyFilters();
    } catch (e) {
      AppLogger.error('Failed to load products', e);
      rethrow;
    }
  }

  /// Load categories from API
  /// Private method for fetching category data
  Future<void> _loadCategories() async {
    try {
      final List<String> categoryList = await ProductService.getCategories();
      _categories.assignAll(categoryList);
    } catch (e) {
      AppLogger.error('Failed to load categories', e);
      rethrow;
    }
  }

  /// Apply search and category filters to products
  /// Updates filtered products list based on current search query and category
  void _applyFilters() {
    List<Product> filtered = List.from(_allProducts);

    // Apply search filter
    if (_searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((product) => product.matchesSearchQuery(_searchQuery.value))
          .toList();
    }

    // Apply category filter
    if (_selectedCategory.value.isNotEmpty) {
      filtered = filtered
          .where((product) => product.matchesCategory(_selectedCategory.value))
          .toList();
    }

    _filteredProducts.assignAll(filtered);

    AppLogger.debug(
      'Applied filters - Search: "${_searchQuery.value}", '
      'Category: "${_selectedCategory.value}", '
      'Results: ${filtered.length}',
    );
  }

  /// Handle search text field changes
  /// Private method for debounced search
  void _onSearchTextChanged() {
    final currentText = searchController.text;
    if (currentText != _searchQuery.value) {
      searchProducts(currentText);
    }
  }

  /// Set loading state
  /// [loading] - Loading state boolean
  void _setLoading(bool loading) {
    _isLoading.value = loading;
  }

  /// Set refreshing state
  /// [refreshing] - Refreshing state boolean
  void _setRefreshing(bool refreshing) {
    _isRefreshing.value = refreshing;
  }

  /// Set error message
  /// [message] - Error message string
  void _setError(String message) {
    _errorMessage.value = message;
  }

  /// Clear error message
  void _clearError() {
    _errorMessage.value = '';
  }
}
