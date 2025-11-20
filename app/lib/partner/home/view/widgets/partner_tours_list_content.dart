import 'package:app/partner/home/widgets/partner_tour_card_widget.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tour_repository/tour_repository.dart';

class PartnerToursListContent extends StatelessWidget {
  const PartnerToursListContent({
    required this.filteredTours,
    super.key,
  });

  final List<TourModel> filteredTours;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          final tour = filteredTours[index];
          return PartnerTourCardWidget(
            tour: tour,
            cacheManager: DefaultCacheManager(),
          );
        },
        separatorBuilder: (_,_) => const SizedBox(height: AppSpacing.md),
        itemCount: filteredTours.length,
      ),
    );
  }
}
