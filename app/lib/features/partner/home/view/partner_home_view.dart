import 'package:app/app/router/app_router.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:tour_repository/tour_repository.dart';

class PartnerHomeView extends StatefulWidget {
  const PartnerHomeView({super.key});

  @override
  State<PartnerHomeView> createState() => _PartnerHomeViewState();
}

class _PartnerHomeViewState extends State<PartnerHomeView> {
  bool _isCheckingVerification = true;

  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  Future<void> _checkVerificationStatus() async {
    try {
      final profileRepository = context.read<ProfileRepository>();
      final status = await profileRepository.getPartnerVerifyStatus();

      if (mounted) {
        // Если статус null или не верифицирован, перенаправляем на страницу верификации
        final verificationStatus = status.verificationStatus;
        
        debugPrint('🔍 Partner verification status: $verificationStatus');
        
        if (verificationStatus == null || verificationStatus != PartnerVerifyStatusEnum.verified) {
          debugPrint('➡️ Redirecting to verification page');
          context.go('/${AppRouter.partner}/${AppRouter.partnerVerification}');
          return;
        }
        
        debugPrint('✅ Partner verified, showing home');
        setState(() {
          _isCheckingVerification = false;
        });
      }
    } catch (e) {
      debugPrint('❌ Error checking verification status: $e');
      debugPrint('➡️ Redirecting to verification page (profile not found)');
      // Если ошибка при проверке (профиль не создан), перенаправляем на верификацию
      if (mounted) {
        context.go('/${AppRouter.partner}/${AppRouter.partnerVerification}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingVerification) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return BlocProvider(
      create: (context) => PartnerToursBloc(context.read<TourRepository>()),
      child: const PartnerHomeViewBody(),
    );
  }
}

class PartnerHomeViewBody extends StatefulWidget {
  const PartnerHomeViewBody({super.key});

  @override
  State<PartnerHomeViewBody> createState() => _PartnerHomeViewBodyState();
}

enum TourFilter { active, inactive }

class _PartnerHomeViewBodyState extends State<PartnerHomeViewBody> {
  final _scrollController = ScrollController();
  TourFilter _selectedFilter = TourFilter.active;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PartnerToursBloc>().add(const PartnerToursFetchEvent());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<PartnerToursBloc>().state;
    if (_isBottom && !state.isLoading && state.hasNextPage) {
      context.read<PartnerToursBloc>().add(const PartnerToursFetchEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  List<TourModel> _getFilteredTours(PartnerToursState state) {
    final allTours = state.pages?.expand((page) => page).toList() ?? [];
    return allTours.where((tour) {
      final isActive = tour.status?.toLowerCase() == 'active' || tour.status?.toLowerCase() == 'активный';
      return _selectedFilter == TourFilter.active ? isActive : !isActive;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onMenuTap: () => context.pushNamed(AppRouter.partnerSettings),
        onNotificationTap: () {},
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PartnerToursBloc>().add(const PartnerToursRefreshEvent());
        },
        child: BlocBuilder<PartnerToursBloc, PartnerToursState>(
          builder: (context, state) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),
                _buildTitle(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.md),
                ),
                _buildFilterTabs(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.md),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Text(
          'Мои туры',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: _FilterTab(
                label: 'Активные',
                isSelected: _selectedFilter == TourFilter.active,
                onTap: () {
                  setState(() {
                    _selectedFilter = TourFilter.active;
                  });
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _FilterTab(
                label: 'Неактивные',
                isSelected: _selectedFilter == TourFilter.inactive,
                onTap: () {
                  setState(() {
                    _selectedFilter = TourFilter.inactive;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateContent(PartnerToursState state) {
    if ((state.pages == null || state.pages!.isEmpty) && state.isLoading) {
      return const PartnerToursLoadingState();
    }

    if (state.error != null && (state.pages?.isEmpty ?? false)) {
      return const PartnerToursErrorState();
    }

    final filteredTours = _getFilteredTours(state);

    if (filteredTours.isEmpty && !state.isLoading) {
      return const PartnerToursEmptyState();
    }

    return PartnerToursListContent(filteredTours: filteredTours);
  }
}

class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
