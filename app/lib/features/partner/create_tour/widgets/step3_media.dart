import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step3Media extends StatelessWidget {
  const Step3Media({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TourMediaCubit, TourMediaState>(
      listener: (context, state) {
        if (state.error != null) {
          context.read<ErrorHandler>().handleError(state.error!, context);
        }
        if (state is TourMediaSuccess) {
          if (state.isMainFilter) {
            context.read<CreateTourFormCubit>().updateMainImageUrl(state.urls.first);
            return;
          }
          final currentCount = context.read<CreateTourFormCubit>().state.imageGalleryUrls.length;
          final remaining = 10 - currentCount;
          if (remaining <= 0) return;

          var newUrls = state.urls;
          if (newUrls.length > remaining) {
            newUrls = newUrls.take(remaining).toList();
            AppSnackbar.showInfo(context: context, title: 'Максимум 10 изображений');
          }
          context.read<CreateTourFormCubit>().addGalleryImageUrls(newUrls);
        }
      },
      child: BlocBuilder<CreateTourFormCubit, CreateTourFormState>(
        builder: (context, formState) {
          return BlocBuilder<TourMediaCubit, TourMediaState>(
            builder: (context, mediaState) {
              return ScrollableBody(
                listViewChildren: [
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Главное изображение *',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (formState.mainImageUrl.isNotEmpty)
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: formState.mainImageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black54,
                            ),
                            onPressed: () {
                              context.read<CreateTourFormCubit>().updateMainImageUrl('');
                            },
                          ),
                        ),
                      ],
                    )
                  else
                    InkWell(
                      onTap: () => context.read<TourMediaCubit>().pickMainImage(context),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: mediaState.isMainImageLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 48,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    'Добавить главное изображение',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Галерея изображений *',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (formState.imageGalleryUrls.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: AppSpacing.sm,
                        mainAxisSpacing: AppSpacing.sm,
                        childAspectRatio: 1,
                      ),
                      itemCount: formState.imageGalleryUrls.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: formState.imageGalleryUrls[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: IconButton(
                                icon: const Icon(Icons.close, size: 18, color: Colors.white),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.black54,
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(24, 24),
                                ),
                                onPressed: () => context.read<CreateTourFormCubit>().removeGalleryImage(index),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  const SizedBox(height: AppSpacing.sm),
                  if (formState.imageGalleryUrls.length < 10)
                    InkWell(
                      onTap: () => context.read<TourMediaCubit>().pickGalleryImages(context),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: mediaState.isGalleryLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 32,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    'Добавить (${10 - formState.imageGalleryUrls.length})',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + AppSpacing.lg),
                ],
                columnChildren: const [],
              );
            },
          );
        },
      ),
    );
  }
}
