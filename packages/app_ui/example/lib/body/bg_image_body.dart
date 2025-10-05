import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class BgImageBodyPage extends StatelessWidget {
  const BgImageBodyPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const BgImageBodyPage());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      appBar: AppBar(elevation: 0, title: const Text('Body')),
      body: Center(child: Assets.images.backgroundUp.image()),
    );
  }
}
