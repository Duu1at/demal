import 'dart:io';

abstract final class Env {
  static String get baseUrl {
    const envUrl = String.fromEnvironment('DEFINEEXAMPLE_BASE_URL');
    if (envUrl.isNotEmpty) {
      return envUrl;
    }
    if (Platform.isIOS) {
      return 'http://172.20.10.4:3000';
    }

    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }
}
