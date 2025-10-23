import 'dart:convert';

import 'package:image_picker/image_picker.dart';

extension XFileX on XFile {
  Future<String> get base64 async => base64Encode(await readAsBytes());
}
