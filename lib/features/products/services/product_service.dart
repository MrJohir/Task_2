import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/api_constants.dart';
import '../../../core/utils/logging/logger.dart';
import '../models/product_model.dart';

/// Product service for handling product-related API calls
/// Uses NetworkCaller for HTTP requests with proper error handling
class ProductService {
  /// Fetch all products from the API
  /// Returns list of Product objects or throws exception on error
  static Future<List<Product>> getAllProducts() async {
    try {
      AppLogger.info('Fetching all products from API');

      // Make API call to get all products
      final responseData = await NetworkCaller.getListRequest(
        ApiConstants.products,
      );

      // Convert response to list of Product objects
      final List<Product> products = responseData
          .map(
            (productJson) =>
                Product.fromJson(productJson as Map<String, dynamic>),
          )
          .toList();

      AppLogger.info('Successfully fetched ${products.length} products');
      return products;
    } catch (e) {
      AppLogger.error('Failed to fetch products', e);
      rethrow;
    }
  }

  /// Fetch products by category
  /// [category] - Category name to filter by
  /// Returns list of Product objects for the specified category
  static Future<List<Product>> getProductsByCategory(String category) async {
    try {
      AppLogger.info('Fetching products for category: $category');

      // Make API call to get products by category
      final responseData = await NetworkCaller.getListRequest(
        ApiConstants.productsByCategory(category),
      );

      // Convert response to list of Product objects
      final List<Product> products = responseData
          .map(
            (productJson) =>
                Product.fromJson(productJson as Map<String, dynamic>),
          )
          .toList();

      AppLogger.info(
        'Successfully fetched ${products.length} products for category: $category',
      );
      return products;
    } catch (e) {
      AppLogger.error('Failed to fetch products for category: $category', e);
      rethrow;
    }
  }

  /// Fetch single product by ID
  /// [productId] - Product ID to fetch
  /// Returns Product object or throws exception on error
  static Future<Product> getProductById(int productId) async {
    try {
      AppLogger.info('Fetching product with ID: $productId');

      // Make API call to get single product
      final responseData = await NetworkCaller.getRequest(
        ApiConstants.product(productId),
      );

      // Convert response to Product object
      final Product product = Product.fromJson(responseData);

      AppLogger.info('Successfully fetched product: ${product.title}');
      return product;
    } catch (e) {
      AppLogger.error('Failed to fetch product with ID: $productId', e);
      rethrow;
    }
  }

  /// Fetch all available categories
  /// Returns list of category strings or throws exception on error
  static Future<List<String>> getCategories() async {
    try {
      AppLogger.info('Fetching product categories');

      // Make API call to get categories
      final responseData = await NetworkCaller.getListRequest(
        ApiConstants.categories,
      );

      // Convert response to list of strings
      final List<String> categories = responseData
          .map((category) => category.toString())
          .toList();

      AppLogger.info('Successfully fetched ${categories.length} categories');
      return categories;
    } catch (e) {
      AppLogger.error('Failed to fetch categories', e);
      rethrow;
    }
  }

  /// Search products by title
  /// [query] - Search query string
  /// Returns filtered list of Product objects
  /// Note: This fetches all products and filters locally since the API doesn't support search
  static Future<List<Product>> searchProducts(String query) async {
    try {
      AppLogger.info('Searching products with query: $query');

      // Fetch all products first
      final List<Product> allProducts = await getAllProducts();

      // Filter products locally based on search query
      final List<Product> filteredProducts = allProducts
          .where((product) => product.matchesSearchQuery(query))
          .toList();

      AppLogger.info(
        'Found ${filteredProducts.length} products matching query: $query',
      );
      return filteredProducts;
    } catch (e) {
      AppLogger.error('Failed to search products with query: $query', e);
      rethrow;
    }
  }

  /// Get products with both search and category filters
  /// [searchQuery] - Search query string (optional)
  /// [category] - Category filter (optional)
  /// Returns filtered list of Product objects
  static Future<List<Product>> getFilteredProducts({
    String? searchQuery,
    String? category,
  }) async {
    try {
      AppLogger.info(
        'Fetching filtered products - Query: $searchQuery, Category: $category',
      );

      List<Product> products;

      // If category is specified, fetch products by category
      if (category != null && category.isNotEmpty) {
        products = await getProductsByCategory(category);
      } else {
        // Otherwise fetch all products
        products = await getAllProducts();
      }

      // Apply search filter if query is provided
      if (searchQuery != null && searchQuery.isNotEmpty) {
        products = products
            .where((product) => product.matchesSearchQuery(searchQuery))
            .toList();
      }

      AppLogger.info(
        'Successfully fetched ${products.length} filtered products',
      );
      return products;
    } catch (e) {
      AppLogger.error('Failed to fetch filtered products', e);
      rethrow;
    }
  }
}
