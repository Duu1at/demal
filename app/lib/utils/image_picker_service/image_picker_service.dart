import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@immutable
final class ImagePickerService {
  const ImagePickerService(this._picker);

  final ImagePicker _picker;

  Future<List<XFile>> pickMultipleImages({
    required BuildContext context,
    double? maxWidth,
    double? maxHeight,
    int? quality,
    int? limit,
    ImageSource? source,
  }) async {
    try {
      final selectedSource = source ?? await _selectImageSource(context);
      if (selectedSource == ImageSource.camera) {
        final image = await _picker.pickImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
          source: ImageSource.camera,
        );
        return image != null ? [image] : [];
      } else if (selectedSource == ImageSource.gallery) {
        if (limit == 1) {
          final image = await _picker.pickImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
            source: ImageSource.gallery,
          );
          return image != null ? [image] : [];
        }
        return _picker.pickMultiImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
          limit: limit,
        );
      } else {
        return [];
      }
    } on Object catch (e, s) {
      log('ImagePickerService.pickMultipleImages error: $e/$s');
      rethrow;
    }
  }

  Future<ImageSource?> _selectImageSource(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('From Camera'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('From Gallery'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
