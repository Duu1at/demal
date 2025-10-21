import 'package:app/client/home/widgets/tour_image_carousel.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TourImageCarousel(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              transform: Matrix4.translationValues(0, -10, 0),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Saint Martin’s Island",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "2400c",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "2025-09-20, 08:00",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Описание",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Arcu, arcu dictumst habitant vel ut et pellentesque.",
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "2025-09-20, 08:00",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Описание",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Arcu, arcu dictumst habitant vel ut et pellentesque.",
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "2025-09-20, 08:00",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Описание",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Arcu, arcu dictumst habitant vel ut et pellentesque.",
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "2025-09-20, 08:00",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Описание",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Arcu, arcu dictumst habitant vel ut et pellentesque.",
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "2025-09-20, 08:00",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Описание",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Arcu, arcu dictumst habitant vel ut et pellentesque.",
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
