import 'package:app/start/widgets/three_points.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class FloatActionBtn extends StatelessWidget {
  const FloatActionBtn({
    super.key,
    this.onPressed,
    required this.title,
    required this.subtitle,
    required this.fillPointIndex,
    required this.textBtn,
  });
  final void Function()? onPressed;
  final String title;
  final String subtitle;
  final String textBtn;
  final int fillPointIndex;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            subtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: const Color(0xff64646E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxxlg),
          ThreePoints(fillIndex: fillPointIndex),
          const SizedBox(height: AppSpacing.spaceUnit * 10),
          AppButton(onPressed: onPressed, child: Text(textBtn)),
        ],
      ),
    );
  }
}
