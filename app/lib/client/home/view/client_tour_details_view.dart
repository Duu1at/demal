import 'package:app/client/home/widgets/tour_image_carousel.dart';
import 'package:app/utils/image_storage/image_storage.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ClientTourDetailsView extends StatefulWidget {
  const ClientTourDetailsView({super.key});

  @override
  State<ClientTourDetailsView> createState() => _ClientTourDetailsViewState();
}

class _ClientTourDetailsViewState extends State<ClientTourDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            stretch: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.40,
            toolbarHeight: 0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                children: [
                  const TourImageCarousel(),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Column(
                children: [SizedBox(height: 16), ContantWidget()],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AppButton(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        onPressed: () {},
        child: const Text('Забронировать тур'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ContantWidget extends StatelessWidget {
  const ContantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const point = LatLng(42.8746, 74.5698);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Flexible(
              child: Text(
                "Saint Martin’s Island",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "2400c",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Assets.icons.clock.svg(
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text("2025-09-20, 08:00", style: theme.textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Assets.icons.star.svg(
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text("4.5", style: theme.textTheme.bodyMedium),
            const SizedBox(width: AppSpacing.xs),
            Text("(150 Reviews)", style: theme.textTheme.bodyMedium),
          ],
        ),
        const DividerHorisontal(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: AvatarIcon(
            imageUrl:
                'https://miro.medium.com/v2/resize:fit:2400/1*Mw7pdECfWJ6sZjN9XU7Jew.png',
            cacheManager: ImageStorage.instance.avatarManager,
          ),
          title: Text(
            "Карельские Приключения",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "Организатор туров",
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const DividerHorisontal(),
        Text(
          "Описание",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const ExpandableText(
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        ),
        const DividerHorisontal(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Что выключено', style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.md),
                  const Row(
                    children: [
                      Icon(Icons.check, size: 20),
                      SizedBox(width: 8),
                      Expanded(child: Text('Питание')),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.check, size: 20),
                      SizedBox(width: 8),
                      Expanded(child: Text('Питание')),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.check, size: 20),
                      SizedBox(width: 8),
                      Expanded(child: Text('Питание')),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Что не выключено', style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.md),
                  const Row(
                    children: [
                      Icon(Icons.close, size: 20),
                      SizedBox(width: 8),
                      Expanded(child: Text('Питание')),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.close, size: 20),
                      SizedBox(width: 8),
                      Expanded(child: Text('Питание')),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.close, size: 20),
                      SizedBox(width: 8),
                      Expanded(child: Text('Питание')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const DividerHorisontal(),
        Text('Программа по дням', style: theme.textTheme.titleMedium),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
            child: const Text('1'),
          ),
          title: Text(
            'Приезд и акклиматизация',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Трансфер из Горно-Алтайска, размещение в базовом лагере',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
            child: const Text('1'),
          ),
          title: Text(
            'Приезд и акклиматизация',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Трансфер из Горно-Алтайска, размещение в базовом лагере',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
            child: const Text('1'),
          ),
          title: Text(
            'Приезд и акклиматизация',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Трансфер из Горно-Алтайска, размещение в базовом лагере',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const DividerHorisontal(),
        Text('Место сбора', style: theme.textTheme.titleMedium),
        Text('ул. Советская, 12, Бишкек', style: theme.textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.lg),
        const SizedBox(
          height: 300,
          child: IgnorePointer(ignoring: false, child: MapExample()),
        ),
        const SizedBox(height: 120),
      ],
    );
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText({super.key, required this.text, this.maxLines = 4});
  final String text;
  final int maxLines;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Text(
            _isExpanded ? "Read less..." : "Read more...",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class MapExample extends StatelessWidget {
  const MapExample({super.key});

  @override
  Widget build(BuildContext context) {
    const point = LatLng(42.8746, 74.5698); // Бишкек

    return FlutterMap(
      options: const MapOptions(initialCenter: point, initialZoom: 10),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          userAgentPackageName: "com.example.app",
          subdomains: const ['a', 'b', 'c', 'd'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: point,
              width: 60,
              height: 60,
              child: const Icon(Icons.location_on, color: Colors.red, size: 50),
            ),
          ],
        ),
      ],
    );
  }
}
