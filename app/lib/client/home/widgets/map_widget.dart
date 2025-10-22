import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const point = LatLng(42.8746, 74.5698);
    return FlutterMap(
      options: const MapOptions(initialCenter: point, initialZoom: 14),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: point,
              width: 60,
              height: 60,
              child: Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
