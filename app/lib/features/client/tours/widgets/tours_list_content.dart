import 'package:app/features/client/tours/bloc/tours_bloc.dart';
import 'package:app/features/client/tours/widgets/tour_card_widget.dart';
import 'package:app/utils/utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToursListContent extends StatelessWidget {
  const ToursListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToursBloc, ToursState>(
      builder: (context, state) {
        final tours = state.pages?.expand((page) => page).toList() ?? [];

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          sliver: SliverList.separated(
            itemBuilder: (context, index) {
              final tour = tours[index];
              return TourCardWidget(
                tour: tour,
                cacheManager: ImageStorage.instance.tourManager,
              );
            },
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemCount: tours.length,
          ),
        );
      },
    );
  }
}
