import 'package:app/app/router/app_router.dart';
import 'package:app/features/client/home/blocs/tours/tours_bloc.dart';
import 'package:app/features/client/home/view/widgets/tours_empty_state.dart';
import 'package:app/features/client/home/view/widgets/tours_error_state.dart';
import 'package:app/features/client/home/view/widgets/tours_list_content.dart';
import 'package:app/features/client/home/view/widgets/tours_loading_state.dart';
import 'package:app/features/client/home/view/widgets/tours_search_bar.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';

class ClientHomeView extends StatelessWidget {
  const ClientHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToursBloc(context.read<TourRepository>()),
      child: const ClientHomeViewBody(),
    );
  }
}

class ClientHomeViewBody extends StatefulWidget {
  const ClientHomeViewBody({super.key});

  @override
  State<ClientHomeViewBody> createState() => _ClientHomeViewBodyState();
}

class _ClientHomeViewBodyState extends State<ClientHomeViewBody> {
  final _searchController = TextEditingController();
  ToursParam _params = const ToursParam();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ToursBloc>().add(const ToursFetchEvent());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final searchQuery = _searchController.text.trim();
    _params = _params.copyWith(
      search: searchQuery.isEmpty ? null : searchQuery,
    );
    context.read<ToursBloc>().add(ToursFilterChangedEvent(_params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onMenuTap: () => context.pushNamed(AppRouter.settings),
        onNotificationTap: () {},
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<ToursBloc>().add(const ToursFetchEvent()),
        child: BlocBuilder<ToursBloc, ToursState<TourModel>>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),
                ToursSearchBar(controller: _searchController),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),
                _buildStateContent(state),
                if (state.isLoading && (state.pages?.isNotEmpty ?? false))
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xl),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRouter.clientTourTickets),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStateContent(ToursState<TourModel> state) {
    if ((state.pages == null || state.pages!.isEmpty) && state.isLoading) {
      return const ToursLoadingState();
    }

    if (state.error != null && (state.pages?.isEmpty ?? false)) {
      return const ToursErrorState();
    }

    if ((state.pages?.isEmpty ?? false) && !state.isLoading) {
      return ToursEmptyState(hasSearchQuery: _searchController.text.isNotEmpty);
    }

    return const ToursListContent();
  }
}
