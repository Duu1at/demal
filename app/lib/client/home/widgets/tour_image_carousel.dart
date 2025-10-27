import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TourImageCarousel extends StatefulWidget {
  const TourImageCarousel({super.key});

  @override
  State<TourImageCarousel> createState() => _TourImageCarouselState();
}

class _TourImageCarouselState extends State<TourImageCarousel> {
  final List<String> _images = [
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    'https://images.unsplash.com/photo-1493558103817-58b2924bce98',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: _images.length,
          options: CarouselOptions(
            height: 400,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: _images[index],
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, child, progress) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorWidget: (context, error, stack) =>
                      const Center(child: Icon(Icons.broken_image, size: 60)),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_images.length, (index) {
              final bool isActive = index == _currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 10 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.white70,
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
