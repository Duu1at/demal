import 'package:flutter/foundation.dart';

import 'package:core/core.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class TourRepositoryMockImpl implements TourRepository {
  const TourRepositoryMockImpl();

  @override
  Future<TourModel> createTour(TourCreateParam param) {
    return Future.delayed(const Duration(seconds: 2), () {
      return const TourModel(
        tourId: '1',
        title: 'Tour 1',
        mainImageUrl: 'https://example.com/image.jpg',
        location: 'Location 1',
        date: '2021-01-01',
        time: '10:00',
        price: 100,
        currency: Currency.USD,
        availableSpots: 10,
        whatsIncluded: ['What is included'],
        whatsNotIncluded: ['What is not included'],
      );
    });
  }

  @override
  Future<TourReviewModel> createTourReview(CreateTourReviewParam param) {
    return Future.delayed(const Duration(seconds: 2), () {
      return TourReviewModel(
        reviewId: '1',
        tourId: '1',
        user: const ReviewUserModel(
          id: '1',
          fullName: 'User 1',
          imageUrl: 'https://example.com/image.jpg',
        ),
        rating: 5,
        text: 'Review 1',
        createdAt: DateTime.now(),
      );
    });
  }

  @override
  Future<void> deleteTour(String tourId) async {
    await Future<void>.delayed(const Duration(seconds: 2));
  }

  @override
  Future<ToursModel> getPartnerTours(int page, int limit) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const ToursModel(
      tours: [
        TourModel(
          tourId: '1',
          title: 'Tour 1',
          mainImageUrl: 'https://example.com/image.jpg',
          location: 'Location 1',
          date: '2021-01-01',
          time: '10:00',
          price: 100,
          currency: Currency.USD,
          availableSpots: 10,
          whatsIncluded: ['What is included'],
          whatsNotIncluded: ['What is not included'],
        ),
        TourModel(
          tourId: '2',
          title: 'Tour 2',
          mainImageUrl: 'https://example.com/image.jpg',
          location: 'Location 2',
          date: '2021-01-02',
          time: '10:00',
          price: 100,
          currency: Currency.USD,
          availableSpots: 10,
          whatsIncluded: ['What is included'],
          whatsNotIncluded: ['What is not included'],
        ),
        TourModel(
          tourId: '3',
          title: 'Tour 3',
          mainImageUrl: 'https://example.com/image.jpg',
          location: 'Location 3',
          date: '2021-01-03',
          time: '10:00',
          price: 100,
          currency: Currency.USD,
          availableSpots: 10,
          whatsIncluded: ['What is included'],
          whatsNotIncluded: ['What is not included'],
        ),
        TourModel(
          tourId: '4',
          title: 'Tour 4',
          mainImageUrl: 'https://example.com/image.jpg',
          location: 'Location 4',
          date: '2021-01-04',
          time: '10:00',
          price: 100,
          currency: Currency.USD,
          availableSpots: 10,
          whatsIncluded: ['What is included'],
          whatsNotIncluded: ['What is not included'],
        ),
        TourModel(
          tourId: '5',
          title: 'Tour 5',
          mainImageUrl: 'https://example.com/image.jpg',
          location: 'Location 5',
          date: '2021-01-05',
          time: '10:00',
          price: 100,
          currency: Currency.USD,
          availableSpots: 10,
          whatsIncluded: ['What is included'],
          whatsNotIncluded: ['What is not included'],
        ),
      ],
      pagination: PaginationResponseModel(
        totalItems: 5,
        totalPages: 1,
        page: 1,
        limit: 20,
      ),
    );
  }

  @override
  Future<ToursModel> getTours(ToursParam? params) {
    return Future.delayed(const Duration(seconds: 2), () {
      return const ToursModel(
        tours: [
          TourModel(
            tourId: '1',
            title: 'Tour 1',
            mainImageUrl: 'https://example.com/image.jpg',
            location: 'Location 1',
            date: '2021-01-01',
            time: '10:00',
            price: 100,
            currency: Currency.USD,
            availableSpots: 10,
            whatsIncluded: ['What is included'],
            whatsNotIncluded: ['What is not included'],
          ),
        ],
        pagination: PaginationResponseModel(
          totalItems: 1,
          totalPages: 1,
          page: 1,
          limit: 20,
        ),
      );
    });
  }

  @override
  Future<TourModel> updateTour(String tourId, TourUpdateParam param) {
    return Future.delayed(const Duration(seconds: 2), () {
      return const TourModel(
        tourId: '1',
        title: 'Tour 1',
        mainImageUrl: 'https://example.com/image.jpg',
        location: 'Location 1',
        date: '2021-01-01',
        time: '10:00',
        price: 100,
        currency: Currency.USD,
        availableSpots: 10,
        whatsIncluded: ['What is included'],
        whatsNotIncluded: ['What is not included'],
        imageGalleryUrls: ['https://example.com/image.jpg'],
      );
    });
  }

  @override
  Future<TourModel> getTourDetail(String tourId) {
    return Future.delayed(const Duration(seconds: 2), () {
      return const TourModel(
        tourId: '1',
        title: 'Tour 1',
        mainImageUrl: 'https://example.com/image.jpg',
        location: 'Location 1',
        date: '2021-01-01',
        time: '10:00',
        price: 100,
        currency: Currency.USD,
        availableSpots: 10,
        whatsIncluded: ['What is included'],
        whatsNotIncluded: ['What is not included'],
        imageGalleryUrls: ['https://example.com/image.jpg'],
      );
    });
  }

  @override
  Future<ToursReviewsModel> getTourReviews(String tourId, int page, int limit) {
    return Future.delayed(const Duration(seconds: 2), () {
      return ToursReviewsModel(
        reviews: [
          TourReviewModel(
            reviewId: '1',
            tourId: '1',
            user: const ReviewUserModel(
              id: '1',
              fullName: 'User 1',
              imageUrl: 'https://example.com/image.jpg',
            ),
            rating: 5,
            text: 'Review 1',
            createdAt: DateTime.now(),
          ),
        ],
        pagination: const PaginationResponseModel(
          totalItems: 1,
          totalPages: 1,
          page: 1,
          limit: 20,
        ),
      );
    });
  }

  @override
  Future<ToursBookingsModel> getBookingsTours(String tourId) {
    return Future.delayed(const Duration(seconds: 2), () {
      return ToursBookingsModel(
        bookings: [
          TourBookingModel(
            bookingId: '1',
            user: const TourBookingUserModel(
              id: '1',
              fullName: 'User 1',
              phoneNumber: '+996555123456',
            ),
            seatsCount: 1,
            totalAmount: '100',
            status: BookingStatusEnum.paid,
            name: 'User 1',
            email: 'user1@example.com',
            createdAt: DateTime.now(),
          ),
        ],
      );
    });
  }
}
