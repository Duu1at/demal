import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:bookings_repository/bookings_repository.dart' as bookings;
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ClientMyTicketsView extends StatefulWidget {
  const ClientMyTicketsView({super.key});

  @override
  State<ClientMyTicketsView> createState() => _ClientMyTicketsViewState();
}

class _ClientMyTicketsViewState extends State<ClientMyTicketsView> {
  late final PagingController<int, bookings.BookingModel> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, bookings.BookingModel>(
      getNextPageKey: (state) {
        if (state.lastPageIsEmpty) return null;
        if (state.keys == null || state.keys!.isEmpty) return 1;
        return state.nextIntPageKey;
      },
      fetchPage: (pageKey) async {
        if (!mounted) return <bookings.BookingModel>[];

        final result = await context.read<bookings.BookingsRepository>().getMyTickets(pageKey);
        return result.bookings;
      },
    );
    _pagingController.addListener(_showError);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _pagingController.refresh();
      }
    });
  }

  Future<void> _showError() async {
    if (_pagingController.value.status == PagingStatus.subsequentPageError) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.l10n.failedToLoadTickets,
            ),
            action: SnackBarAction(
              label: context.l10n.retry,
              onPressed: () => _pagingController.fetchNextPage(),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      bgImageTop: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(context.l10n.myTickets, style: theme.textTheme.titleLarge),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async => _pagingController.refresh(),
        child: PagingListener(
          controller: _pagingController,
          builder: (context, state, fetchNextPage) {
            return PagedListView<int, bookings.BookingModel>.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              padding: const EdgeInsets.all(AppSpacing.lg),
              builderDelegate: PagedChildBuilderDelegate(
                animateTransitions: true,
                itemBuilder: (context, booking, index) => TicketCard(booking: booking),
                firstPageErrorIndicatorBuilder: (context) => FirstPageError(
                  onRetry: () => context.read<bookings.BookingsRepository>().getMyTickets(20),
                ),
                newPageErrorIndicatorBuilder: (context) => NewPageError(
                  onRetry: () => _pagingController.fetchNextPage(),
                ),
                firstPageProgressIndicatorBuilder: (context) => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                newPageProgressIndicatorBuilder: (context) => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                noItemsFoundIndicatorBuilder: (context) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.confirmation_number_outlined,
                          size: 64,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          context.l10n.noTickets,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
            );
          },
        ),
      ),
    );
  }
}
