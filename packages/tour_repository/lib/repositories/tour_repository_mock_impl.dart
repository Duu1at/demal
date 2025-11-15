import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class TourRepositoryMockImpl implements TourRepository {
  const TourRepositoryMockImpl();

  @override
  Future<TourModel> getClientTourDetail(String tourId) async {
    return TourModel(
      tourId: '63296682-0d17-4746-9f2f-1fac4366f5a0',
      title: 'Тур по озеру Иссык-Куль',
      mainImageUrl: 'https://example.com/main-image.jpg',
      location: 'Озеро Иссык-Куль',
      tourType: 'Активный отдых',
      date: '2024-06-15',
      time: '09:00',
      price: 5000,
      currency: 'KGS',
      availableSpots: 20,
      description: 'Прекрасный однодневный тур с посещением основных достопримечательностей',
      program: const {
        '09:00': 'Встреча',
        '10:00': 'Выезд',
        '12:00': 'Прибытие',
      },

      whatsIncluded: const ['Трансфер', 'Обед', 'Гид'],
      whatsNotIncluded: const ['Личные расходы', 'Алкоголь'],
      whatToBring: 'Удобная одежда, солнцезащитный крем, вода',
      imageGalleryUrls: const [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
      ],
      organizer: const OrganizerModel(
        id: '45393e26-ca81-4ac7-82e2-13a823ead911',
        fullName: 'Исабек Абазов',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/NestJS.svg/1200px-NestJS.svg.png',
      ),
      status: 'ACTIVE',
      averageRating: 0,
      reviewsCount: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<ToursModel> getClientTours(ToursParam params) async {
    const data = {
      'success': true,
      'tours': [
        {
          'tour_id': '63296682-0d17-4746-9f2f-1fac4366f5a0',
          'title': 'Тур по озеру Иссык-Куль',
          'main_image_url': 'https://example.com/main-image.jpg',
          'location': 'Озеро Иссык-Куль',
          'tour_type': 'Активный отдых',
          'date': '2024-06-15',
          'time': '09:00',
          'price': 5000,
          'currency': 'KGS',
          'available_spots': 20,
          'description': 'Прекрасный однодневный тур с посещением основных достопримечательностей',
          'program': {
            '09:00': 'Встреча',
            '10:00': 'Выезд',
            '12:00': 'Прибытие',
          },
          'meeting_point': {
            'address': 'Бишкек, пр. Чуй, 145',
            'coordinates': '42.8746,74.5698',
          },
          'whats_included': ['Трансфер', 'Обед', 'Гид'],
          'whats_not_included': ['Личные расходы', 'Алкоголь'],
          'what_to_bring': 'Удобная одежда, солнцезащитный крем, вода',
          'image_gallery_urls': [
            'https://example.com/image1.jpg',
            'https://example.com/image2.jpg',
          ],
          'organizer': {
            'id': '45393e26-ca81-4ac7-82e2-13a823ead911',
            'fullName': 'Исабек Абазов',
            'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/NestJS.svg/1200px-NestJS.svg.png',
          },
          'status': 'ACTIVE',
          'average_rating': null,
          'reviews_count': 0,
          'created_at': '2025-11-02T12:54:52.322Z',
          'updated_at': '2025-11-02T12:54:52.322Z',
        },
        {
          'tour_id': 'f5521b86-0520-4b74-a5ab-bb13bd7ccac4',
          'title': 'Тур по озеру Иссык-Куль 2',
          'main_image_url': 'https://example.com/main-image.jpg',
          'location': 'Озеро Иссык-Куль',
          'tour_type': 'Активный отдых',
          'date': '2024-06-15',
          'time': '09:00',
          'price': 5000,
          'currency': 'KGS',
          'available_spots': 20,
          'description': 'однодневный тур с посещением основных достопримечательностей',
          'program': {
            '09:00': 'Встреча',
            '10:00': 'Выезд',
            '12:00': 'Прибытие',
          },
          'meeting_point': {
            'address': 'Бишкек, пр. Чуй, 145',
            'coordinates': '42.8746,74.5698',
          },
          'whats_included': ['Трансфер', 'Обед', 'Гид'],
          'whats_not_included': ['Личные расходы', 'Алкоголь'],
          'what_to_bring': 'Удобная одежда, солнцезащитный крем, вода',
          'image_gallery_urls': [
            'https://example.com/image1.jpg',
            'https://example.com/image2.jpg',
          ],
          'organizer': {
            'id': '45393e26-ca81-4ac7-82e2-13a823ead911',
            'fullName': 'Исабек Абазов',
            'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/NestJS.svg/1200px-NestJS.svg.png',
          },
          'status': 'ACTIVE',
          'average_rating': null,
          'reviews_count': 0,
          'created_at': '2025-11-02T12:52:25.189Z',
          'updated_at': '2025-11-02T12:54:10.899Z',
        },
        {
          'tour_id': '3563b2b0-482f-4c0f-bf15-c0bc9a9f4302',
          'title': 'Тур по озеру Иссык-Куль',
          'main_image_url': 'https://example.com/main-image.jpg',
          'location': 'Озеро Иссык-Куль',
          'tour_type': 'Горы2',
          'date': '2024-06-15',
          'time': '09:00',
          'price': 5000,
          'currency': 'KGS',
          'available_spots': 20,
          'description': 'Прекрасный однодневный тур с посещением основных достопримечательностей',
          'program': {
            '09:00': 'Встреча',
            '10:00': 'Выезд',
            '12:00': 'Прибытие',
          },
          'meeting_point': {
            'address': 'Бишкек, пр. Чуй, 145',
            'coordinates': '42.8746,74.5698',
          },
          'whats_included': ['Трансфер', 'Обед', 'Гид'],
          'whats_not_included': ['Личные расходы', 'Алкоголь'],
          'what_to_bring': 'Удобная одежда, солнцезащитный крем, вода',
          'image_gallery_urls': [
            'https://example.com/image1.jpg',
            'https://example.com/image2.jpg',
          ],
          'organizer': {
            'id': '45393e26-ca81-4ac7-82e2-13a823ead911',
            'fullName': 'Исабек Абазов',
            'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/NestJS.svg/1200px-NestJS.svg.png',
          },
          'status': 'ACTIVE',
          'average_rating': null,
          'reviews_count': 0,
          'created_at': '2025-11-02T11:14:55.280Z',
          'updated_at': '2025-11-02T11:39:59.323Z',
        },
        {
          'tour_id': '373d25fd-659f-4366-ac3d-6dcb593247fe',
          'title': 'Тур по озеру Иссык-Куль',
          'main_image_url': 'https://example.com/main-image.jpg',
          'location': 'Озеро Иссык-Куль',
          'tour_type': 'Активный отдых',
          'date': '2024-06-15',
          'time': '09:00',
          'price': 5000,
          'currency': 'KGS',
          'available_spots': 20,
          'description': 'Прекрасный однодневный тур с посещением основных достопримечательностей',
          'program': {
            '09:00': 'Встреча',
            '10:00': 'Выезд',
            '12:00': 'Прибытие',
          },
          'meeting_point': {
            'address': 'Бишкек, пр. Чуй, 145',
            'coordinates': '42.8746,74.5698',
          },
          'whats_included': ['Трансфер', 'Обед', 'Гид'],
          'whats_not_included': ['Личные расходы', 'Алкоголь'],
          'what_to_bring': 'Удобная одежда, солнцезащитный крем, вода',
          'image_gallery_urls': [
            'https://example.com/image1.jpg',
            'https://example.com/image2.jpg',
          ],
          'organizer': {
            'id': '45393e26-ca81-4ac7-82e2-13a823ead911',
            'fullName': 'Исабек Абазов',
            'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/NestJS.svg/1200px-NestJS.svg.png',
          },
          'status': 'ACTIVE',
          'average_rating': null,
          'reviews_count': 0,
          'created_at': '2025-11-02T11:14:33.140Z',
          'updated_at': '2025-11-02T11:14:33.140Z',
        },
      ],
      'pagination': {
        'page': 1,
        'limit': 20,
        'total_items': 4,
        'total_pages': 1,
      },
    };

    return ToursModel.fromJson(data);
  }

  @override
  Future<void> createPartnerTour(TourCreateParam tourCreateParam) {
    throw UnimplementedError();
  }

  @override
  Future<void> deletePartnerTour(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<TourDetailModel> getClientTourTickets(int page, int limit) {
    throw UnimplementedError();
  }

  @override
  Future<void> getPartnerTours(ToursParam params) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePartnerTour(String tourId, TourCreateParam tourCreateParam) {
    throw UnimplementedError();
  }

  @override
  Future<void> createTourReview(CreateTourReviewParam createTourReviewParam) {
    // TODO: implement createTourReview
    throw UnimplementedError();
  }

  @override
  Future<void> getTourReviews(String tourId, int page, int limit) {
    // TODO: implement getTourReviews
    throw UnimplementedError();
  }
}
