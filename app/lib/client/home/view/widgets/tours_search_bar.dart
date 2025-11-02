import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ToursSearchBar extends StatelessWidget {
  const ToursSearchBar({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: SearchTextField(
        onChanged: (_) {},
        hintText: 'Search any tours...',
        controller: controller,
      ),
    );
  }
}

