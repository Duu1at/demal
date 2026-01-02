import 'package:flutter/material.dart';

class TourDetailErrorWidget extends StatelessWidget {
  const TourDetailErrorWidget(this.error, {super.key});
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
