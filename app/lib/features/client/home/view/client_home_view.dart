import 'package:app/app/app.dart';
import 'package:app/app/router/nav_helper.dart';
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
  final _scrollController = ScrollController();
  ToursParam _params = const ToursParam();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ToursBloc>().add(const ToursFetchNext(1));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<ToursBloc>().state;
      if (state.hasNextPage && !state.isLoading) {
        final nextPage = (state.keys?.length ?? 0) + 1;
        context.read<ToursBloc>().add(ToursFetchNext(nextPage));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged() {
    final searchQuery = _searchController.text.trim();
    _params = _params.copyWith(
      search: searchQuery.isEmpty ? null : searchQuery,
    );
    context.read<ToursBloc>().add(ToursFilterChanged(_params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onMenuTap: () => context.pushNamed(AppRouteNames.settings),
        onNotificationTap: () {},
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<ToursBloc>().add(const ToursRefresh()),
        child: BlocBuilder<ToursBloc, ToursState>(
          builder: (context, state) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
                ToursSearchBar(controller: _searchController),
                const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
                _buildStateContent(state),
                if (state.isLoading && (state.pages?.isNotEmpty ?? false))
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamedIfAuthenticated(AppRouteNames.clientTourTickets),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStateContent(ToursState state) {
    final isEmpty = state.pages == null || state.pages!.isEmpty || state.pages!.every((page) => page.isEmpty);

    if (isEmpty && state.isLoading) {
      return const ToursLoadingState();
    }

    if (state.error != null && isEmpty) {
      return const ToursErrorState();
    }

    if (isEmpty && !state.isLoading) {
      return ToursEmptyState(hasSearchQuery: _searchController.text.isNotEmpty);
    }

    return const ToursListContent();
  }
}
