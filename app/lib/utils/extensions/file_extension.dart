import 'dart:convert';
import 'package:share_plus/share_plus.dart';

extension XFileX on XFile {
  Future<String> get base64 async => base64Encode(await readAsBytes());
}
