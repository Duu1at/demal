import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

abstract class AppShare {
  static Future<void> shareUri({
    required BuildContext context,
    required String url,
    Rect? sharePositionOrigin,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    try {
      await SharePlus.instance.share(
        ShareParams(
          uri: Uri.parse(url),
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        ),
      );
    } on Exception catch (e, s) {
      log('share error: $e, \n launch stack-trace: $s');
    }
  }
}
