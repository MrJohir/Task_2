import 'rating_model.dart';

/// Product model for fake store API
/// Contains all product information with proper null safety
class Product {
  /// Product ID
  final int id;

  /// Product title
  final String title;

  /// Product price
  final double price;

  /// Product description
  final String description;

  /// Product category
  final String category;

  /// Product image URL
  final String image;

  /// Product rating information
  final Rating rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  /// Create Product from JSON
  /// [json] - JSON map containing product data
  /// Returns Product object with null safety
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      image: json['image'] as String? ?? '',
      rating: json['rating'] != null
          ? Rating.fromJson(json['rating'] as Map<String, dynamic>)
          : Rating.empty(),
    );
  }

  /// Convert Product to JSON
  /// Returns JSON map representation
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

  /// Create empty Product object
  /// Returns Product with default values
  factory Product.empty() {
    return Product(
      id: 0,
      title: '',
      price: 0.0,
      description: '',
      category: '',
      image: '',
      rating: Rating.empty(),
    );
  }

  /// Create copy of Product with updated fields
  /// Returns new Product instance with updated values
  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }

  /// Check if product matches search query
  /// [query] - Search query string
  /// Returns true if product title or category contains query
  bool matchesSearchQuery(String query) {
    if (query.isEmpty) return true;

    final lowercaseQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowercaseQuery) ||
        category.toLowerCase().contains(lowercaseQuery) ||
        description.toLowerCase().contains(lowercaseQuery);
  }

  /// Check if product belongs to specific category
  /// [categoryFilter] - Category to filter by
  /// Returns true if product category matches filter
  bool matchesCategory(String? categoryFilter) {
    if (categoryFilter == null || categoryFilter.isEmpty) return true;
    return category.toLowerCase() == categoryFilter.toLowerCase();
  }

  /// Get formatted price string
  /// Returns price formatted with currency symbol
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Get formatted rating string
  /// Returns rating formatted as "rate/5.0 (count reviews)"
  String get formattedRating =>
      '${rating.rate.toStringAsFixed(1)}/5.0 (${rating.count} reviews)';

  /// Get capitalized category name
  /// Returns category with first letter capitalized
  String get capitalizedCategory {
    if (category.isEmpty) return category;
    return category
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  /// Get truncated title
  /// [maxLength] - Maximum length for title
  /// Returns truncated title with ellipsis if needed
  String getTruncatedTitle(int maxLength) {
    if (title.length <= maxLength) return title;
    return '${title.substring(0, maxLength)}...';
  }

  /// Get truncated description
  /// [maxLength] - Maximum length for description
  /// Returns truncated description with ellipsis if needed
  String getTruncatedDescription(int maxLength) {
    if (description.length <= maxLength) return description;
    return '${description.substring(0, maxLength)}...';
  }

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $price, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
