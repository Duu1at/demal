import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageStorage {
  static final ImageStorage _instance = ImageStorage._();

  static ImageStorage get instance => _instance;

  final CacheManager avatarManager;

  static const kAvatarCahceKey = 'kAvatarCahceKey';

  ImageStorage._()
    : avatarManager = CacheManager(
        Config(kAvatarCahceKey, stalePeriod: const Duration(minutes: 30)),
      );

  Future<void> clearAllData() async {
    await Future.wait([avatarManager.emptyCache()]);
  }
}
