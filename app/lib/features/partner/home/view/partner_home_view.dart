import 'package:app/app/router/app_router.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';

class PartnerHomeView extends StatefulWidget {
  const PartnerHomeView({super.key});

  @override
  State<PartnerHomeView> createState() => _PartnerHomeViewState();
}

class _PartnerHomeViewState extends State<PartnerHomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartnerToursBloc(context.read<TourRepository>()),
      child: const _PartnerHomeView(),
    );
  }
}

class _PartnerHomeView extends StatelessWidget {
  const _PartnerHomeView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
         onMenuTap: () {
    final rootContext = navigatorKey.currentContext;
    if (rootContext == null) return;

    GoRouter.of(rootContext).pushNamed(AppRouter.settings);
  },
        onNotificationTap: () {},
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          PartnerHomeFilterTabs(
            selectedFilter: TourFilter.active,
            onFilterChanged: (filter) {},
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
            sliver: PartnerToursPagination(),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
