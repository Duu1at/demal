import 'package:app/core/core.dart';
import 'package:flutter/material.dart';

@immutable
final class DialogErrorHandle implements ErrorHandle<DialogErrorHandleParam> {
  const DialogErrorHandle._();

  static const DialogErrorHandle instance = DialogErrorHandle._();

  @override
  void handleError(DialogErrorHandleParam param) {
    final model = Parser.getModel(param.error);
    showAdaptiveDialog<void>(
      context: param.context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Column(
            children: [
              if (model.icon != null)
                Padding(
                  padding: const EdgeInsetsGeometry.all(8),
                  child: model.icon,
                ),
              Text(model.title),
            ],
          ),
          content: Text(model.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
