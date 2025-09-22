/// Rating model for product ratings
/// Contains rating value and count information
class Rating {
  /// Rating value (1-5 scale)
  final double rate;

  /// Number of ratings
  final int count;

  const Rating({required this.rate, required this.count});

  /// Create Rating from JSON
  /// [json] - JSON map containing rating data
  /// Returns Rating object with null safety
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }

  /// Convert Rating to JSON
  /// Returns JSON map representation
  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }

  /// Create empty Rating object
  /// Returns Rating with default values
  factory Rating.empty() {
    return const Rating(rate: 0.0, count: 0);
  }

  @override
  String toString() {
    return 'Rating(rate: $rate, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Rating && other.rate == rate && other.count == count;
  }

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;
}
