import 'dart:io';
import 'package:app/core/core.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showVersionUpdateDialog(
  BuildContext context, {
  required VersionCheckService versionCheckService,
  required UpdateType updateType,
}) async {
  if (updateType == UpdateType.none) return;

  final l10n = AppLocalizations.of(context);
  final isForceUpdate = updateType == UpdateType.force;

  final title = isForceUpdate ? l10n.updateRequired : l10n.updateAvailable;

  final content = isForceUpdate ? l10n.updateRequiredMessage : l10n.updateAvailableMessage;

  void updateAction() {
    versionCheckService.launchStore();
  }

  await showDialog<void>(
    context: context,
    barrierDismissible: !isForceUpdate,
    builder: (dialogContext) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            if (!isForceUpdate)
              CupertinoDialogAction(
                child: Text(l10n.updateLater),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                updateAction();
                if (!isForceUpdate) {
                  Navigator.of(dialogContext).pop();
                }
              },
              child: Text(l10n.updateNow),
            ),
          ],
        );
      }

      return PopScope(
        canPop: !isForceUpdate,
        child: AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(title, style: const TextStyle(color: Colors.black)),
          content: Text(content, style: const TextStyle(color: Colors.black)),
          actions: [
            if (!isForceUpdate)
              TextButton(
                child: Text(l10n.updateLater),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
            TextButton(
              onPressed: () {
                updateAction();
                if (!isForceUpdate) {
                  Navigator.of(dialogContext).pop();
                }
              },
              child: Text(l10n.updateNow),
            ),
          ],
        ),
      );
    },
  );
}
