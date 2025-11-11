import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageStorage {
  ImageStorage._()
    : avatarManager = CacheManager(
        Config(kAvatarCacheKey, stalePeriod: const Duration(days: 30)),
      ),
      tourManager = CacheManager(
        Config(kTourCacheKey, stalePeriod: const Duration(days: 30)),
      );


  static final ImageStorage _instance = ImageStorage._();

  static ImageStorage get instance => _instance;

  final CacheManager avatarManager;
  final CacheManager tourManager;

  static const kAvatarCacheKey = 'kAvatarCacheKey';
  static const kTourCacheKey = 'kTourCacheKey';

  Future<void> clearAllData() async {
    await Future.wait([avatarManager.emptyCache(), tourManager.emptyCache()]);
  }
}
