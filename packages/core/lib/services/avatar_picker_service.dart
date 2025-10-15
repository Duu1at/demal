import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum _AvatarAction { camera, gallery, delete }

class AvatarPickerService {
  static Future<_AvatarAction?> _showActionSheet(BuildContext context) {
    return showModalBottomSheet<_AvatarAction>(
      context: context,
      builder: (c) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take photo'),
                onTap: () => Navigator.pop(c, _AvatarAction.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Choose from gallery'),
                onTap: () => Navigator.pop(c, _AvatarAction.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Remove photo'),
                onTap: () => Navigator.pop(c, _AvatarAction.delete),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<File?> pickFrom(BuildContext context) async {
    final action = await _showActionSheet(context);
    if (action == null) return null;
    if (action == _AvatarAction.delete) return File.fromUri(Uri());
    final ImageSource src = action == _AvatarAction.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    try {
      final XFile? picked = await ImagePicker().pickImage(
        source: src,
        imageQuality: 70,
        maxWidth: 700,
        maxHeight: 700,
      );
      if (picked == null) return null;
      return File(picked.path);
    } catch (err) {
      rethrow;
    }
  }
}
