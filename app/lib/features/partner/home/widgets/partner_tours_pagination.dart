import 'package:app/features/partner/partner.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tour_repository/tour_repository.dart';

class PartnerToursPagination extends StatefulWidget {
  const PartnerToursPagination({super.key});

  @override
  State<PartnerToursPagination> createState() => _PartnerToursPaginationState();
}

class _PartnerToursPaginationState extends State<PartnerToursPagination> {
  late final PartnerToursBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<PartnerToursBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nextPage();
    });
  }

  void _nextPage() {
    _bloc.add(const PartnerToursFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerToursBloc, PartnerToursState>(
      bloc: _bloc,
      builder: (context, state) {
        final hasLoadedAnything = state.pages?.isNotEmpty ?? false;
        if (!hasLoadedAnything) {
          if (state.isLoading) {
            return const PartnerToursLoadingState();
          }
          if (state.error != null) {
            return PartnerToursErrorState(onRetry: _nextPage);
          }
          return const PartnerToursEmptyState();
        }
        return PagedSliverList<int, TourModel>(
          key: const Key('partner_tours_pagination'),
          state: state,
          fetchNextPage: _nextPage,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) {
              return PartnerTourCard(
                tour: item,
                cacheManager: ImageStorage.instance.tourManager,
              );
            },
          ),
        );
      },
    );
  }
}
