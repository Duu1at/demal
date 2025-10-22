import 'package:app/utils/image_storage/image_storage.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TourOrganizerTile extends StatelessWidget {
  const TourOrganizerTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        AvatarIcon(
          imageUrl:
              'https://miro.medium.com/v2/resize:fit:2400/1*Mw7pdECfWJ6sZjN9XU7Jew.png',
          cacheManager: ImageStorage.instance.avatarManager,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MountainTrip Agency",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Организатор тура",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
