import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

abstract final class PermissionReqeuster {
  static Future<void> requestCamera({
    void Function(PermissionStatus status)? onDenied,
    void Function(PermissionStatus status)? onGranted,
    void Function(PermissionStatus status)? onPermissionGrantedCallback,
    void Function(PermissionStatus status)? onPermanentlyDenied,
  }) async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      onGranted?.call(status);
      onPermissionGrantedCallback?.call(status);
    } else if (status.isDenied) {
      onDenied?.call(status);
    } else if (status.isPermanentlyDenied) {
      onPermanentlyDenied?.call(status);
    } else {
      onDenied?.call(status);
    }
  }

  static Future<void> requestGallery({
    void Function(PermissionStatus status)? onDenied,
  }) async {
    final status = await Permission.photos.request();
    if (status != PermissionStatus.granted) {
      onDenied?.call(status);
    }
  }
}
