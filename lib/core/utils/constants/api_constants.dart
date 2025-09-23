class ApiConstants {
  /// Base URL for fake store API
  static const String baseUrl = 'https://fakestoreapi.com';

  /// Products endpoint
  static const String products = '$baseUrl/products';

  /// Product categories endpoint
  static const String categories = '$baseUrl/products/categories';

  /// Single product endpoint
  static String product(int id) => '$baseUrl/products/$id';

  /// Products by category endpoint
  static String productsByCategory(String category) =>
      '$baseUrl/products/category/$category';
}
