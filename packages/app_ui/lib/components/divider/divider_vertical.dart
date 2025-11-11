import 'package:flutter/material.dart';

class DividerVertical extends StatelessWidget {
  const DividerVertical({super.key, this.color = const Color(0xffD1D3DB)});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: VerticalDivider(width: 1, thickness: 1, color: color),
    );
  }
}
