/// Утилиты для TourCard
class TourCardUtils {
  TourCardUtils._();

  static String formatPrice(double? price) {
    if (price == null) return '\$0.00 /person';
    return '\$${price.toStringAsFixed(2)} /person';
  }


  static String formatDuration(String? duration, String? distance) {
    final parts = <String>[];
    if (duration != null && duration.isNotEmpty) {
      parts.add(duration);
    }
    if (distance != null && distance.isNotEmpty) {
      parts.add(distance);
    }
    return parts.isEmpty ? '' : parts.join(' • ');
  }

 
  static String formatLocation(String? city, String? country) {
    final parts = <String>[];
    if (city != null && city.isNotEmpty) {
      parts.add(city);
    }
    if (country != null && country.isNotEmpty) {
      parts.add(country);
    }
    return parts.isEmpty ? '' : parts.join(', ');
  }

  
  static String formatReviewsCount(int? count) {
    if (count == null || count == 0) return '0 Reviews';
    return '$count Reviews';
  }
}
