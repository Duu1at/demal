import 'package:flutter/material.dart';

class ThreePoints extends StatelessWidget {
  const ThreePoints({super.key, this.fillIndex = 0});
  final int fillIndex;

  Color _getFillColor(int index) {
    if (index == fillIndex) {
      return Colors.black;
    } else {
      return const Color(0xffE5D1AE);
    }
  }

  Widget _getCircleView(int index) {
    return Card(
      margin: EdgeInsets.zero,
      child: SizedBox(
        width: 10,
        height: 10,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getFillColor(index),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_getCircleView(0), _getCircleView(1), _getCircleView(2)],
      ),
    );
  }
}
