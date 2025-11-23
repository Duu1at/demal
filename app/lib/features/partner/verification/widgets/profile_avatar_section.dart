import 'dart:io';
import 'package:app/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({
    required this.profileImageFile,
    required this.profileImageUrl,
    required this.onImageSelected,
    super.key,
    this.onEditPressed,
  });

  final File? profileImageFile;
  final String? profileImageUrl;
  final ValueChanged<File> onImageSelected;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          _buildAvatar(context),
          _buildEditButton(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    if (profileImageFile != null) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: FileImage(profileImageFile!),
      );
    }

    return AvatarWidget(
      avatarUrl: profileImageUrl,
      size: 100,
      isActive: true,
      expand: true,
      onUpdate: onImageSelected,
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: onEditPressed,
        ),
      ),
    );
  }
}
