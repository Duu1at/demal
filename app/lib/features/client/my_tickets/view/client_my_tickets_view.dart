import 'package:app/utils/formatter/formatter.dart';
import 'package:app_ui/app_ui.dart';
import 'package:bookings_repository/bookings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
            content: const Text(
              'Произошла ошибка при загрузке данных.',
            ),
            action: SnackBarAction(
              label: 'Повторить',
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
        title: Text('Мои билеты', style: theme.textTheme.titleLarge),
      ),
      body: RefreshIndicator(
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
                    child: CircularProgressIndicator(),
                  ),
                ),
                newPageProgressIndicatorBuilder: (context) => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: CircularProgressIndicator(),
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
                          'У вас пока нет билетов',
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

  String _formatStatus(BookingStatusEnum? status) {
    return switch (status) {
      BookingStatusEnum.pending => 'Ожидает подтверждения',
      BookingStatusEnum.confirmed => 'Подтверждено',
      BookingStatusEnum.paid => 'Оплачено',
      BookingStatusEnum.completed => 'Завершено',
      BookingStatusEnum.cancelled => 'Отменено',
      null => 'Неизвестно',
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
                text: 'Дата и время: ',
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
                text: 'Место сбора: ',
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
                text: 'Количество мест: ',
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
                text: 'Статус: ',
                style: theme.textTheme.bodyMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: '"${_formatStatus(booking.status)}"',
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
              'Итоговая сумма: ${booking.totalAmount} ${AppCurrencyFormatter.cuccancyType('KGZ')}',
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
              'Не удалось загрузить билеты',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Проверьте подключение к интернету',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Повторить'),
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
            'Не удалось загрузить следующую страницу',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
