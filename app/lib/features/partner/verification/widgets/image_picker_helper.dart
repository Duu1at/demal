import 'dart:io';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> pickImage({
    required BuildContext context,
    ImageQuality quality = ImageQuality.medium,
  }) async {
    try {
      final source = await _selectImageSource(context);
      if (source == null) return null;

      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: source,
        imageQuality: quality.value,
      );

      if (file != null) {
        return File(file.path);
      }
      return null;
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при выборе изображения: $e')),
        );
      }
      return null;
    }
  }

  static Future<ImageSource?> _selectImageSource(BuildContext context) {
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
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Сделать снимок'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Открыть галерею'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum ImageQuality {
  low(60),
  medium(85),
  high(100);

  const ImageQuality(this.value);
  final int value;
}
