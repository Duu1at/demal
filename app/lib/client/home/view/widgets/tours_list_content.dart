import 'package:app/client/home/blocs/tours/tours_bloc.dart';
import 'package:app/client/home/widgets/tour_card/tour_card_widget.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class ToursListContent extends StatelessWidget {
  const ToursListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToursBloc, ToursState>(
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          sliver: SliverList.separated(
            itemBuilder: (context, index) {
              if (index >= state.tours.length) {
                return const BottomLoader();
              }
              final tour = state.tours[index];
              return TourCardWidget(
                tour: tour,
                cacheManager: DefaultCacheManager(),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemCount: state.hasReachedMax
                ? state.tours.length
                : state.tours.length + 1,
          ),
        );
      },
    );
  }
}


class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}

