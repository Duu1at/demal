import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorBodyWidget extends StatelessWidget {
  const ErrorBodyWidget(this.error, {super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final model = context.read<ErrorHandler>().parseErrorModel(error, context);
    return Column(
      children: [
        if (model.icon != null)
          Padding(
            padding: const EdgeInsetsGeometry.all(8),
            child: model.icon,
          ),
        Text(model.title),
        Text(model.message),
      ],
    );
  }
}
