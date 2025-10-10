import 'package:flutter/material.dart';

class DividerHorisontal extends StatelessWidget {
  const DividerHorisontal({
    super.key,
    this.color = const Color(0xffD1D3DB),
    this.padding = const EdgeInsets.all(8.0),
  });
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(thickness: 1.5, color: color, indent: 0, endIndent: 0),
    );
  }
}
