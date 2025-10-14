import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SpacingPage());
  }

  @override
  Widget build(BuildContext context) {
    const spacingList = [
      SpacingItem(spacing: AppSpacing.lg, name: 'lg'),
      SpacingItem(spacing: AppSpacing.md, name: 'md'),
      SpacingItem(spacing: AppSpacing.sm, name: 'sm'),
      SpacingItem(spacing: AppSpacing.spaceUnit, name: 'spaceUnit'),
      SpacingItem(spacing: AppSpacing.xl, name: 'xl'),
      SpacingItem(spacing: AppSpacing.xlg, name: 'xlg'),
      SpacingItem(spacing: AppSpacing.xs, name: 'xs'),
      SpacingItem(spacing: AppSpacing.xxlg, name: 'xxlg'),
      SpacingItem(spacing: AppSpacing.xxxlg, name: 'xxxlg'),
      SpacingItem(spacing: AppSpacing.xxxxlg, name: 'xxxxlg'),
      SpacingItem(spacing: AppSpacing.xxxxxxlg, name: 'xxxxxxlg'),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(title: const Text('Spacing')),
      body: Center(
        child: ListView.builder(itemCount: spacingList.length, itemBuilder: (_, index) => spacingList[index]),
      ),
    );
  }
}

class SpacingItem extends StatelessWidget {
  const SpacingItem({required this.spacing, required this.name, super.key});

  final double spacing;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(color: AppColors.orange, width: AppSpacing.xxlg, height: AppSpacing.lg),
              Container(color: AppColors.orange, width: AppSpacing.xxlg, height: AppSpacing.lg),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(name),
        ],
      ),
    );
  }
}
