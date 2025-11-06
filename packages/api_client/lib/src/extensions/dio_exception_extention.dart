import 'package:dio/dio.dart';

const _badResponsePatterns = [
  'XMLHttpRequest error',
  'SocketException',
  'Connection closed',
  'HandshakeException',
  'FormatException',
  'Unexpected character',
];

extension DioExceptionX on DioException {
  String? get getReadableMessage {
    final msg = message?.trim() ?? '';
    if (msg.isEmpty) return null;
    for (final p in _badResponsePatterns) {
      if (msg.contains(p)) return null;
    }
    return msg;
  }
}
