import 'package:app/app/app.dart';
import 'package:app/features/client/home/blocs/tours/tours_bloc.dart';
import 'package:app/features/client/home/widgets/tour_card/tour_card_widget.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';

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
                cacheManager: DefaultCacheManager(),
                onTap: () {
                  context.pushNamed(
                    AppRouteNames.clientTourDetails,
                    pathParameters: {'tourId': tour.tourId ?? ''},
                  );
                },
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
