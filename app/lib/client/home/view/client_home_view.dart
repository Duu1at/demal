import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ClientHomeView extends StatelessWidget {
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
    
      ),
      body: ListView(
        children: [
          TourCard(
            imageUrl: 'https://picsum.photos/400/250',
            rating: 5.0,
            ratingCount: 12,
            typeOfTour: 'Type Of Tour',
            title: 'Card Title',
            features: ['Pickup Available', 'Skip the Line', 'Enter Free'],
            duration: 'Duration',
            distance: 'Miles Away',
            city: 'City',
            country: 'Country',
            oldPrice: 100.00,
            price: 0.00,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          TourCard(
            imageUrl: 'https://picsum.photos/400/250',
            rating: 5.0,
            ratingCount: 12,
            typeOfTour: 'Type Of Tour',
            title: 'Card Title',
            features: ['Pickup Available', 'Skip the Line', 'Enter Free'],
            duration: 'Duration',
            distance: 'Miles Away',
            city: 'City',
            country: 'Country',
            oldPrice: 100.00,
            price: 0.00,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
