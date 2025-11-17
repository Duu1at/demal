import 'package:meta/meta.dart';
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
        currency: 'USD',
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
  Future<ToursModel> getPartnerTours(int page, int limit) {
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
            currency: 'USD',
            availableSpots: 10,
            whatsIncluded: ['What is included'],
            whatsNotIncluded: ['What is not included'],
          ),
        ],
        pagination: PaginationModel(
          totalItems: 1,
          totalPages: 1,
          page: 1,
          limit: 20,
        ),
      );
    });
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
            currency: 'USD',
            availableSpots: 10,
            whatsIncluded: ['What is included'],
            whatsNotIncluded: ['What is not included'],
          ),
        ],
        pagination: PaginationModel(
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
        currency: 'USD',
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
        currency: 'USD',
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
        pagination: const PaginationModel(
          totalItems: 1,
          totalPages: 1,
          page: 1,
          limit: 20,
        ),
      );
    });
  }
}
