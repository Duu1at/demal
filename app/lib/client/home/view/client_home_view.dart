import 'package:app/app/router/app_router.dart';
import 'package:app/client/home/blocs/tours/tours_bloc.dart';
import 'package:app/client/home/view/tours_scroll_controller.dart';
import 'package:app/client/home/view/widgets/tours_empty_state.dart';
import 'package:app/client/home/view/widgets/tours_error_state.dart';
import 'package:app/client/home/view/widgets/tours_list_content.dart';
import 'package:app/client/home/view/widgets/tours_loading_state.dart';
import 'package:app/client/home/view/widgets/tours_search_bar.dart';
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

class _ClientHomeViewBodyState extends State<ClientHomeViewBody> with ToursScrollControllerMixin {
  final _searchController = TextEditingController();
  ToursParam _params = const ToursParam();

  @override
  void initState() {
    super.initState();
    initializeScrollController();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ToursBloc>().add(const ToursInitialFetchEvent());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    disposeScrollController();
    super.dispose();
  }

  void _onSearchChanged() {
    final searchQuery = _searchController.text.trim();
    _params = _params.copyWith(
      search: searchQuery.isEmpty ? null : searchQuery,
    );
    context.read<ToursBloc>().add(ToursFilterChangedEvent(_params));
  }

  Future<void> _onRefresh() async {
    context.read<ToursBloc>().add(const ToursRefreshEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onMenuTap: () => context.pushNamed(AppRouter.clientSettings),
        onNotificationTap: () {},
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<ToursBloc, ToursPagingState>(
          builder: (context, state) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),
                ToursSearchBar(controller: _searchController),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),
                _buildStateContent(state),
                if (state.isLoading && state.allTours.isNotEmpty && !state.isRefreshing)
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

  Widget _buildStateContent(ToursPagingState state) {
    if ((state.pages == null || state.pages!.isEmpty) && state.isLoading) {
      return const ToursLoadingState();
    }

    if (state.error != null && state.allTours.isEmpty) {
      return const ToursErrorState();
    }

    if (state.allTours.isEmpty && !state.isLoading) {
      return ToursEmptyState(hasSearchQuery: _searchController.text.isNotEmpty);
    }

    return const ToursListContent();
  }
}
