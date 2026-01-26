import 'package:app_ui/app_ui.dart';
import 'package:core/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  Future<PackageInfo> _getAppVersion() async {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder(
      future: _getAppVersion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
          return const SizedBox.shrink();
        }
        return Text(
          '${context.l10n.version} ${snapshot.data?.version} (${snapshot.data?.buildNumber})',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: context.appColors.disabled,
          ),
        );
      },
    );
  }
}
