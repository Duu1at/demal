import 'package:tour_repository/tour_repository.dart';

extension TourModelExtensions on TourModel {
  Map<String, String?> parseLocation() {
    if (location == null || location!.isEmpty) {
      return {'city': null, 'country': null};
    }

    final parts = location!.split(',').map((e) => e.trim()).toList();

    if (parts.length >= 2) {
      return {'city': parts[0], 'country': parts[1]};
    } else {
      return {'city': parts[0], 'country': null};
    }
  }

  String? formatDuration() {
    if (date == null && time == null) return null;

    final parts = <String>[];

    if (date != null) {
      parts.add(date!);
    }

    if (time != null) {
      parts.add(time!);
    }

    return parts.isEmpty ? null : parts.join(' • ');
  }

  String? get city => parseLocation()['city'];

  String? get country => parseLocation()['country'];
}
