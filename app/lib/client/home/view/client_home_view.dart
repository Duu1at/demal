import 'package:app/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';
import 'package:go_router/go_router.dart';

class ClientHomeView extends StatefulWidget {
  const ClientHomeView({super.key});

  @override
  State<ClientHomeView> createState() => _ClientHomeViewState();
}

class _ClientHomeViewState extends State<ClientHomeView> {
  final _controller = TextEditingController();

  Future<void> _onBottomRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(onMenuTap: () {}, onNotificationTap: () {}),
      body: RefreshIndicator(
        onRefresh: _onBottomRefresh,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
            SliverAppBar(
              pinned: false,
              floating: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: SearchTextField(
                onChanged: (_) {},
                hintText: 'Search any tours...',
                controller: _controller,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              sliver: SliverList.separated(
                itemBuilder: (context, index) => TourCard(
                  imageUrl:
                      'https://avatars.mds.yandex.net/i?id=b4f305847bbf6a7b444a16a92ef1556f_l-10132791-images-thumbs&n=13',
                  rating: 5.0,
                  ratingCount: 12,
                  typeOfTour: 'Adventure',
                  title: 'Explore the Mountains',
                  features: ['Pickup', 'Skip the Line', 'Free Entry'],
                  duration: '5h',
                  distance: '2km',
                  city: 'City',
                  country: 'Country',
                  oldPrice: 100,
                  price: 80,
                  onTap: () {
                    context.goNamed(AppRouter.clientTourDetails);
                  },
                  onBookTap: () {},
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: 18,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>context.goNamed(AppRouter.clientTourTickets),
        child: const Icon(Icons.add),
      ),
    );
  }
}
