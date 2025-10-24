import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final List<TextSpan> textSpans;

  const BulletPoint({super.key, required this.textSpans});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '• ',
            style: TextStyle(
              fontSize: 14.0,
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          Expanded(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
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
