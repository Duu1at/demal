import 'dart:async';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DynamicColorCarousel extends StatefulWidget {
  const DynamicColorCarousel({
    super.key,
    required this.imageUrls,
    this.height = 300,
    this.onAccentColorChanged,
    this.fit = BoxFit.cover,
    this.enableAutoPlay = true,
  });
  final List<String> imageUrls;
  final double height;
  final ValueChanged<Color>? onAccentColorChanged;
  final BoxFit fit;
  final bool enableAutoPlay;

  @override
  State<DynamicColorCarousel> createState() => _DynamicColorCarouselState();
}

class _DynamicColorCarouselState extends State<DynamicColorCarousel> {
  int _currentIndex = 0;
  Color _accentColor = Colors.white;
  late final double h;
  @override
  void initState() {
    super.initState();
    _updateAccentColor(widget.imageUrls[_currentIndex]);
    h = MediaQuery.of(context).size.height * 0.4;
  }

  Future<void> _updateAccentColor(String url) async {
    try {
      // final cached = await CachedNetworkImageProvider(
      //   url,
      // ).obtainKey(const ImageConfiguration());
      final imageStream = CachedNetworkImageProvider(
        url,
      ).resolve(const ImageConfiguration());

      final completer = Completer<ui.Image>();
      late ImageStreamListener listener;

      listener = ImageStreamListener((info, _) {
        completer.complete(info.image);
        imageStream.removeListener(listener);
      });

      imageStream.addListener(listener);

      final ui.Image image = await completer.future;
      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );
      if (byteData == null) return;

      final pixels = byteData.buffer.asUint32List();
      int r = 0, g = 0, b = 0;
      final int step = (pixels.length ~/ 30000).clamp(1, 50);

      for (int i = 0; i < pixels.length; i += step) {
        final color = pixels[i];
        r += (color >> 16) & 0xFF;
        g += (color >> 8) & 0xFF;
        b += color & 0xFF;
      }

      final count = (pixels.length / step).floor();
      r ~/= count;
      g ~/= count;
      b ~/= count;

      final color = Color.fromARGB(255, r, g, b);
      if (mounted) {
        setState(() => _accentColor = color);
        widget.onAccentColorChanged?.call(color);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          options: CarouselOptions(
            height: h,
            viewportFraction: 1,
            autoPlay: widget.enableAutoPlay,
            autoPlayInterval: const Duration(seconds: 5),
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
              _updateAccentColor(widget.imageUrls[index]);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return CachedNetworkImage(
              imageUrl: widget.imageUrls[index],
              fit: widget.fit,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.broken_image, size: 60)),
            );
          },
        ),
        Positioned(
          bottom: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              final isActive = index == _currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 10 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? _accentColor.withValues(alpha: 0.9)
                      : _accentColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
