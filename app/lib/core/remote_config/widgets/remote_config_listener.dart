import 'dart:io';
import 'package:app/core/core.dart';
import 'package:app/utils/utils.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RemoteConfigListener extends StatelessWidget {
  const RemoteConfigListener({
    required this.child,
    required this.navigationKey,
    super.key,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigationKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoteConfigCubit, RemoteConfigModel>(
      listenWhen: (p, c) => p.appVersion != c.appVersion,
      listener: (context, state) {
        final currentBuildNumber = int.tryParse(context.read<PackageInfo>().buildNumber) ?? 0;
        final platform = Platform.isIOS ? 'ios' : 'android';
        if (state.isUpdateRequired(platform, currentBuildNumber)) {
          _showUpdateDialog(context, forceUpdate: true);
          return;
        }

        if (state.isUpdateRecommended(platform, currentBuildNumber)) {
          _showUpdateDialog(context);
        }
      },
      child: child,
    );
  }

  void _showUpdateDialog(
    BuildContext context, {
    bool forceUpdate = false,
  }) {
    final ctx = navigationKey.currentState!.overlay!.context;
    final title = forceUpdate ? ctx.l10n.updateRequired : ctx.l10n.updateAvailable;
    final content = forceUpdate ? ctx.l10n.updateRequiredMessage : ctx.l10n.updateAvailableMessage;
    showAdaptiveDialog<void>(
      context: ctx,
      barrierDismissible: !forceUpdate,
      builder: (ctx) {
        return PopScope(
          canPop: !forceUpdate,
          child: AlertDialog.adaptive(
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(content),
            actions: [
              if (!forceUpdate)
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    ctx.l10n.updateLater,
                    textAlign: TextAlign.center,
                  ),
                ),
              TextButton(
                onPressed: () => AppLaunch.launchURL(_getPlatformAppStoreLink),
                child: Text(
                  ctx.l10n.updateNow,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String get _getPlatformAppStoreLink {
    if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=com.demal.app';
    } else {
      return 'https://apps.apple.com/us/app/demal/id6758624069';
    }
  }
}
