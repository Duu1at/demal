import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:app/features/client/tours/bloc/tours_bloc.dart';
import 'package:tour_repository/tour_repository.dart';
import 'package:core/core.dart';

class MockTourRepository extends Mock implements TourRepository {}

void main() {
  group('ToursBloc', () {
    late TourRepository tourRepository;
    late ToursBloc toursBloc;

    setUp(() {
      tourRepository = MockTourRepository();
      toursBloc = ToursBloc(tourRepository);
      registerFallbackValue(const ToursParam());
    });

    tearDown(() {
      toursBloc.close();
    });

    final mockTours = [
      const TourModel(tourId: '1', title: 'Tour 1'),
      const TourModel(tourId: '2', title: 'Tour 2'),
    ];

    final mockResponse = ToursModel(
      tours: mockTours,
      pagination: const PaginationResponseModel(
        page: 1,
        limit: 10,
        totalItems: 25,
        totalPages: 3,
      ),
    );

    group('Initial State', () {
      test('initial state is correct', () {
        expect(toursBloc.state.pages, isNull);
        expect(toursBloc.state.keys, isNull);
        expect(toursBloc.state.error, isNull);
        expect(toursBloc.state.hasNextPage, isTrue);
        expect(toursBloc.state.isLoading, isFalse);
        expect(toursBloc.state.params, isNull);
      });
    });

    group('ToursFetchNext', () {
      test('emits loading and success states when fetching first page', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => mockResponse,
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursFetchNext(1));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.length, greaterThanOrEqualTo(2));
        expect(states[0].isLoading, isTrue);
        expect(states[1].isLoading, isFalse);
        expect(states[1].pages?.length, 1);
        expect(states[1].pages?.first, mockTours);
        expect(states[1].keys, const [1]);
        expect(states[1].hasNextPage, isTrue);

        await subscription.cancel();
      });

      test('emits loading and success states when fetching second page', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => ToursModel(
            tours: mockTours,
            pagination: const PaginationResponseModel(
              page: 2,
              limit: 10,
              totalItems: 25,
              totalPages: 3,
            ),
          ),
        );

        toursBloc.emit(
          ToursState(
            isLoading: false,
            hasNextPage: true,
            pages: [mockTours],
            keys: const [1],
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursFetchNext(2));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.length, greaterThanOrEqualTo(2));
        expect(states.last.pages?.length, 2);
        expect(states.last.keys, const [1, 2]);

        await subscription.cancel();
      });

      test('detects last page from pagination metadata', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => ToursModel(
            tours: mockTours,
            pagination: const PaginationResponseModel(
              page: 3,
              limit: 10,
              totalItems: 30,
              totalPages: 3,
            ),
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursFetchNext(3));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.last.hasNextPage, isFalse);

        await subscription.cancel();
      });

      test('emits error state when fetch fails', () async {
        when(() => tourRepository.getTours(any())).thenThrow(
          Exception('Network error'),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursFetchNext(1));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.last.error, isA<Exception>());
        expect(states.last.isLoading, isFalse);

        await subscription.cancel();
      });

      test('does not fetch when already loading', () async {
        toursBloc
          ..emit(ToursState(isLoading: true, hasNextPage: true))
          ..add(const ToursFetchNext(1));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        verifyNever(() => tourRepository.getTours(any()));
      });

      test('does not fetch when no next page', () async {
        toursBloc
          ..emit(ToursState(isLoading: false, hasNextPage: false))
          ..add(const ToursFetchNext(1));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        verifyNever(() => tourRepository.getTours(any()));
      });

      test('handles empty response', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => const ToursModel(
            tours: [],
            pagination: PaginationResponseModel(
              page: 1,
              limit: 10,
              totalItems: 0,
              totalPages: 1,
            ),
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursFetchNext(1));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.last.pages?.first, isEmpty);
        expect(states.last.hasNextPage, isFalse);

        await subscription.cancel();
      });
    });

    group('ToursRefresh', () {
      test('resets state and fetches first page', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => mockResponse,
        );

        toursBloc.emit(
          ToursState(
            isLoading: false,
            hasNextPage: false,
            pages: [mockTours, mockTours],
            keys: const [1, 2],
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursRefresh());

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.last.pages?.length, 1);
        expect(states.last.keys, const [1]);

        await subscription.cancel();
      });

      test('preserves params when refreshing', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => mockResponse,
        );

        toursBloc.emit(
          ToursState(
            isLoading: false,
            hasNextPage: true,
            params: const ToursParam(search: 'test'),
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursRefresh());

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.last.params?.search, 'test');

        verify(
          () => tourRepository.getTours(
            any(
              that: predicate<ToursParam>(
                (p) => p.search == 'test' && p.page == 1 && p.limit == 10,
              ),
            ),
          ),
        ).called(1);

        await subscription.cancel();
      });

      test('handles refresh error', () async {
        when(() => tourRepository.getTours(any())).thenThrow(
          Exception('Network error'),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursRefresh());

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.last.error, isA<Exception>());
        expect(states.last.hasNextPage, isFalse);

        await subscription.cancel();
      });
    });

    group('ToursFilterChanged', () {
      test('applies filter and resets pagination', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => ToursModel(
            tours: [mockTours.first],
            pagination: const PaginationResponseModel(
              page: 1,
              limit: 10,
              totalItems: 1,
              totalPages: 1,
            ),
          ),
        );

        toursBloc.emit(
          ToursState(
            isLoading: false,
            hasNextPage: false,
            pages: [mockTours, mockTours],
            keys: const [1, 2],
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(
          const ToursFilterChanged(ToursParam(search: 'beach')),
        );

        await Future<void>.delayed(const Duration(milliseconds: 600));

        expect(states.last.params?.search, 'beach');
        expect(states.last.pages?.length, 1);
        expect(states.last.keys, const [1]);

        verify(
          () => tourRepository.getTours(
            any(
              that: predicate<ToursParam>(
                (p) => p.search == 'beach' && p.page == 1 && p.limit == 10,
              ),
            ),
          ),
        ).called(1);

        await subscription.cancel();
      });

      test('handles filter with empty results', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => const ToursModel(
            tours: [],
            pagination: PaginationResponseModel(
              page: 1,
              limit: 10,
              totalItems: 0,
              totalPages: 1,
            ),
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(
          const ToursFilterChanged(ToursParam(search: 'nonexistent')),
        );

        await Future<void>.delayed(const Duration(milliseconds: 600));

        expect(states.last.pages?.first, isEmpty);
        expect(states.last.hasNextPage, isFalse);

        await subscription.cancel();
      });

      test('applies multiple filters', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => ToursModel(
            tours: [mockTours.first],
            pagination: const PaginationResponseModel(
              page: 1,
              limit: 10,
              totalItems: 1,
              totalPages: 1,
            ),
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(
          const ToursFilterChanged(
            ToursParam(
              search: 'beach',
              location: 'Bali',
              priceMin: 100,
              priceMax: 500,
              sortBy: TourSortBy.priceAsc,
            ),
          ),
        );

        await Future<void>.delayed(const Duration(milliseconds: 600));

        verify(
          () => tourRepository.getTours(
            any(
              that: predicate<ToursParam>(
                (p) =>
                    p.search == 'beach' &&
                    p.location == 'Bali' &&
                    p.priceMin == 100 &&
                    p.priceMax == 500 &&
                    p.sortBy == TourSortBy.priceAsc &&
                    p.page == 1 &&
                    p.limit == 10,
              ),
            ),
          ),
        ).called(1);

        await subscription.cancel();
      });
    });

    group('Edge Cases', () {
      test('handles null tours in response', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => const ToursModel(
            tours: null,
            pagination: PaginationResponseModel(
              page: 1,
              limit: 10,
              totalItems: 0,
              totalPages: 1,
            ),
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursFetchNext(1));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.last.pages?.first, isEmpty);

        await subscription.cancel();
      });

      test('handles null pagination in response', () async {
        when(() => tourRepository.getTours(any())).thenAnswer(
          (_) async => const ToursModel(
            tours: [TourModel(tourId: '1', title: 'Tour 1')],
            pagination: null,
          ),
        );

        final states = <ToursState>[];
        final subscription = toursBloc.stream.listen(states.add);

        toursBloc.add(const ToursFetchNext(1));

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(states.last.pages?.first.length, 1);
        // When pagination is null and items < pageSize, we assume it's the last page
        expect(states.last.hasNextPage, isFalse);

        await subscription.cancel();
      });
    });
  });
}
