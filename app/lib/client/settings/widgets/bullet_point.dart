import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  const BulletPoint({required this.textSpans, super.key});
  final List<TextSpan> textSpans;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '• ',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  height: 1.5,
                ),
                children: textSpans,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
