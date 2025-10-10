import 'package:flutter/material.dart';

class DividerHorisontal extends StatelessWidget {
  const DividerHorisontal({super.key, this.color = const Color(0xffD1D3DB)});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(thickness: 1.5, color: color, indent: 16, endIndent: 16),
    );
  }
}
