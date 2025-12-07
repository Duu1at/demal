import 'dart:io';

import 'package:app/utils/image_storage/image_storage.dart';
import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarDisplay extends StatelessWidget {
  const AvatarDisplay({
    super.key,
    this.avatarUrl,
    this.imageFile,
    this.size = 72,
    this.onTap,
    this.heroTag,
    this.placeholder,
    this.backgroundColor,
  });

  final String? avatarUrl;
  final File? imageFile;
  final double size;
  final VoidCallback? onTap;
  final Object? heroTag;
  final WidgetBuilder? placeholder;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (imageFile != null) {
      content = Image.file(
        imageFile!,
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    } else if (avatarUrl?.isNotEmpty ?? false) {
      content = CachedNetworkImage(
        imageUrl: avatarUrl!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        cacheManager: ImageStorage.instance.avatarManager,
        placeholder: (context, url) => ShimmerContainer(
          width: size,
          height: size,
          radius: size,
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(context),
      );
    } else {
      content = placeholder?.call(context) ?? _buildPlaceholder(context);
    }

    Widget result = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? context.appColors.bgCard,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: content,
      ),
    );

    if (onTap != null) {
      result = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: result,
      );
    }

    if (heroTag != null) {
      result = Hero(
        tag: heroTag!,
        child: result,
      );
    }

    return result;
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
      child: Assets.icons.user.svg(
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
