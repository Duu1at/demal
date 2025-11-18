import 'package:app/utils/utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tour_repository/tour_repository.dart';

class TourReviewsBottomSheet extends StatefulWidget {
  const TourReviewsBottomSheet({
    required this.tourId,
    required this.tourTitle,
    super.key,
  });

  final String tourId;
  final String tourTitle;

  @override
  State<TourReviewsBottomSheet> createState() => _TourReviewsBottomSheetState();
}

class _TourReviewsBottomSheetState extends State<TourReviewsBottomSheet> {
  late final PagingController<int, TourReviewModel> _pagingController;
  static const int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, TourReviewModel>(
      getNextPageKey: (state) {
        if (state.lastPageIsEmpty) return null;
        if (state.keys == null || state.keys!.isEmpty) return 1;
        return state.nextIntPageKey;
      },
      fetchPage: (pageKey) async {
        if (!mounted) return <TourReviewModel>[];
        final result = await context.read<TourRepository>().getTourReviews(
          widget.tourId,
          pageKey,
          _pageSize,
        );
        return result.reviews ?? [];
      },
    );
    _pagingController.addListener(_showError);
  }

  Future<void> _showError() async {
    if (_pagingController.value.status == PagingStatus.subsequentPageError) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Произошла ошибка при загрузке отзывов.',
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
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              'Отзывы',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: PagingListener(
              controller: _pagingController,
              builder: (context, state, fetchNextPage) {
                return PagedListView<int, TourReviewModel>(
                  state: state,
                  fetchNextPage: fetchNextPage,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  builderDelegate: PagedChildBuilderDelegate(
                    animateTransitions: true,
                    itemBuilder: (context, review, index) => _ReviewCard(review: review),
                    firstPageErrorIndicatorBuilder: (context) => _FirstPageError(
                      onRetry: () => _pagingController.refresh(),
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
                              Icons.comment_outlined,
                              size: 64,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Пока нет отзывов',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final TourReviewModel review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = review.user;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (user?.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    user!.imageUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AvatarIcon(
                        imageUrl: user.imageUrl,
                        cacheManager: ImageStorage.instance.avatarManager,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 24,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              const SizedBox(width: AppSpacing.sm),
              // Имя пользователя и рейтинг
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.fullName ?? 'Анонимный пользователь',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (review.rating != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            final starIndex = index + 1;
                            return Icon(
                              starIndex <= (review.rating ?? 0).round() ? Icons.star : Icons.star_border,
                              size: 16,
                              color: starIndex <= (review.rating ?? 0).round()
                                  ? Colors.amber
                                  : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                            );
                          }),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            review.rating!.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Дата
              if (review.createdAt != null)
                Text(
                  AppDateFormats.formatDdMMYyyy.format(review.createdAt!),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
            ],
          ),
          // Текст отзыва
          if (review.text != null && review.text!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              review.text!,
              style: theme.textTheme.bodyMedium,
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
              'Не удалось загрузить отзывы',
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
