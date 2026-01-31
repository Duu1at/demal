import 'package:app/utils/formatter/formatter.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:bookings_repository/bookings_repository.dart' hide BookingStatusEnum;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tour_repository/tour_repository.dart';

class ClientMyTicketsView extends StatefulWidget {
  const ClientMyTicketsView({super.key});

  @override
  State<ClientMyTicketsView> createState() => _ClientMyTicketsViewState();
}

class _ClientMyTicketsViewState extends State<ClientMyTicketsView> {
  late final PagingController<int, BookingModel> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, BookingModel>(
      getNextPageKey: (state) {
        if (state.lastPageIsEmpty) return null;
        if (state.keys == null || state.keys!.isEmpty) return 1;
        return state.nextIntPageKey;
      },
      fetchPage: (pageKey) async {
        if (!mounted) return <BookingModel>[];

        final result = await context.read<BookingsRepository>().getMyTickets(pageKey);
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
            return PagedListView<int, BookingModel>.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              padding: const EdgeInsets.all(AppSpacing.lg),
              builderDelegate: PagedChildBuilderDelegate(
                animateTransitions: true,
                itemBuilder: (context, booking, index) => _BookingCard(booking: booking),
                firstPageErrorIndicatorBuilder: (context) => _FirstPageError(
                  onRetry: () => context.read<BookingsRepository>().getMyTickets(20),
                ),
                newPageErrorIndicatorBuilder: (context) => _NewPageError(
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

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.booking});

  final BookingModel booking;

  String _formatStatus(BuildContext context, BookingStatusEnum? status) {
    return switch (status) {
      BookingStatusEnum.pending => context.l10n.statusPending,
      BookingStatusEnum.confirmed => context.l10n.statusConfirmed,
      BookingStatusEnum.paid => context.l10n.statusPaid,
      BookingStatusEnum.completed => context.l10n.statusCompleted,
      BookingStatusEnum.cancelled => context.l10n.statusCancelled,
      null => context.l10n.statusUnknown,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tour = booking.tour;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tour?.title != null)
            Text(
              tour!.title!,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          if (tour?.date != null && tour?.time != null) ...[
            const SizedBox(height: AppSpacing.xs),
            RichText(
              text: TextSpan(
                text: context.l10n.dateAndTime,
                style: theme.textTheme.bodyMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: '${AppDateFormats.formatDdMMYyyy.format(tour!.date!)} ${tour.time ?? ''}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (tour?.location != null) ...[
            const SizedBox(height: AppSpacing.xs),
            RichText(
              text: TextSpan(
                text: context.l10n.gatheringPlace,
                style: theme.textTheme.bodyMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: tour!.location,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (booking.seatsCount != null) ...[
            const SizedBox(height: AppSpacing.xs),
            RichText(
              text: TextSpan(
                text: context.l10n.seatsCount,
                style: theme.textTheme.bodyMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: '${booking.seatsCount}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (booking.status != null) ...[
            const SizedBox(height: AppSpacing.xs),
            RichText(
              text: TextSpan(
                text: context.l10n.statusLabel,
                style: theme.textTheme.bodyMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: '"${_formatStatus(context, booking.status as BookingStatusEnum?)}"',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (booking.totalAmount != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              '${context.l10n.totalAmount(booking.totalAmount.toString())} ${AppCurrencyFormatter.cuccancyType(Currency.KGS)}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FirstPageError extends StatelessWidget {
  const _FirstPageError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              context.l10n.failedToLoadTickets,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.checkInternetConnection,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewPageError extends StatelessWidget {
  const _NewPageError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.failedToLoadNextPage,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: onRetry,
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }
}
