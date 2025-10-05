import 'package:app_ui/app_ui.dart';
import 'package:example/typography/theme_typography_page.dart';
import 'package:flutter/material.dart';

class AppTypographyPage extends StatelessWidget {
  const AppTypographyPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AppTypographyPage());
  }

  @override
  Widget build(BuildContext context) {
    const textThemes = [
      TextItem(name: 'Headling 1', style: AppTypography.heading1),
      TextItem(name: 'Heading 2', style: AppTypography.heading2),
      TextItem(name: 'Headling 3', style: AppTypography.heading3),
      TextItem(name: 'Headline 4', style: AppTypography.heading4),
      TextItem(name: 'Headline 5', style: AppTypography.heading5),
      TextItem(name: 'Body Bold', style: AppTypography.bodyBold),
      TextItem(name: 'Body Large Regular', style: AppTypography.bodyLargeBold),
      TextItem(name: 'Body Large Medium', style: AppTypography.bodyLargeMedium),
      TextItem(name: 'Body Large Regular', style: AppTypography.bodyLargeRegular),
      TextItem(name: 'Body Medium', style: AppTypography.bodyMedium),
      TextItem(name: 'Body Regular', style: AppTypography.bodyRegular),
      TextItem(name: 'Body Small Bold', style: AppTypography.bodySmallBold),
      TextItem(name: 'Body Small Medium', style: AppTypography.bodySmallMedium),
      TextItem(name: 'Body Small Regular', style: AppTypography.bodySmallRegular),
      TextItem(name: 'Body Large Bold', style: AppTypography.bodyLargeBold),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text('Typography')),
      body: ListView.builder(
        itemCount: textThemes.length,
        itemBuilder: (context, index) {
          return textThemes[index];
        },
      ),
    );
  }
}
