import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ModalBaseComponent extends StatelessWidget {
  const ModalBaseComponent({
    super.key,
    this.title = 'Title',
    this.textButton = 'Button Text',
    this.onPressed,
    this.child,
  });

  final String? title;
  final String textButton;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const DividerHorisontal(
                padding: EdgeInsets.symmetric(vertical: 4),
              ),
              child ?? const SizedBox(),
              const SizedBox(height: 16),
              AppButton(
                size: AppButtonSize.sm,
                onPressed: onPressed,
                child: Text(textButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
