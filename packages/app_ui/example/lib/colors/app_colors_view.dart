import 'package:app_ui/app_ui.dart';
import 'package:example/colors/theme_colors_view.dart';
import 'package:flutter/material.dart';

class AppColorsView extends StatelessWidget {
  const AppColorsView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AppColorsView());
  }

  @override
  Widget build(BuildContext context) {
    const colorItems = [
      ColorSquare(name: 'error50', color: AppColors.error50),
      ColorSquare(name: 'error700', color: AppColors.error700),
      ColorSquare(name: 'error900', color: AppColors.error900),
      ColorSquare(name: 'info50', color: AppColors.info50),
      ColorSquare(name: 'info700', color: AppColors.info700),
      ColorSquare(name: 'info900', color: AppColors.info900),
      ColorSquare(name: 'neutral0', color: AppColors.neutral0),
      ColorSquare(name: 'Neutral50', color: AppColors.neutral50),
      ColorSquare(name: 'Neutral100', color: AppColors.neutral100),
      ColorSquare(name: 'Neutral200', color: AppColors.neutral200),
      ColorSquare(name: 'Neutral300', color: AppColors.neutral300),
      ColorSquare(name: 'Neutral900', color: AppColors.neutral900),

      ColorSquare(name: 'Primary50', color: AppColors.primary50),
      ColorSquare(name: 'Primary700', color: AppColors.primary700),
      ColorSquare(name: 'Primary900', color: AppColors.primary900),
      ColorSquare(name: 'secondary50', color: AppColors.secondary50),
      ColorSquare(name: 'secondary700', color: AppColors.secondary700),
      ColorSquare(name: 'secondary900', color: AppColors.secondary900),
      ColorSquare(name: 'success50', color: AppColors.success50),
      ColorSquare(name: 'success700', color: AppColors.success700),
      ColorSquare(name: 'success900', color: AppColors.success900),
      ColorSquare(name: 'text0', color: AppColors.text0),
      ColorSquare(name: 'text300', color: AppColors.text300),
      ColorSquare(name: 'text400', color: AppColors.text400),
      ColorSquare(name: 'text500', color: AppColors.text500),
      ColorSquare(name: 'text600', color: AppColors.text600),
      ColorSquare(name: 'text900', color: AppColors.text900),
      ColorSquare(name: 'warning50', color: AppColors.warning50),
      ColorSquare(name: 'warning700', color: AppColors.warning700),
      ColorSquare(name: 'warning900', color: AppColors.warning900),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text('App Colors')),
      body: GridView.builder(
        itemCount: colorItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (_, index) => colorItems[index],
      ),
    );
  }
}
