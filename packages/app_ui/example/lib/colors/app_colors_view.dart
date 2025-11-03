import 'package:flutter/material.dart';

class AppColorsView extends StatelessWidget {
  const AppColorsView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AppColorsView());
  }

  @override
  Widget build(BuildContext context) {
    const colorItems = [];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text('App Colors')),
      body: GridView.builder(
        itemCount: colorItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (_, index) => colorItems[index],
      ),
    );
  }
}
