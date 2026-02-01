import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToursErrorState extends StatelessWidget {
  const ToursErrorState(this.error, {super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final errorModel = context.read<ErrorHandler>().parseErrorModel(error);
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ?errorModel.icon,
              const SizedBox(height: AppSpacing.lg),
              Text(
                context.read<ErrorHandler>().parseErrorMessage(error),

                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
