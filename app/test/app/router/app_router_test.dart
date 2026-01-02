import 'package:app/app/app.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

class MockGoRouterState extends Mock implements GoRouterState {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('AppRouterRedirect', () {
    late AuthCubit authCubit;
    late AppRouterRedirect appRouterRedirect;
    late GoRouterState state;
    late BuildContext context;

    setUp(() {
      authCubit = MockAuthCubit();
      appRouterRedirect = AppRouterRedirect(authCubit);
      state = MockGoRouterState();
      context = MockBuildContext();
    });

    test('returns null when auth status is initial', () {
      when(() => authCubit.state).thenReturn(const AuthState.initial());
      when(() => state.uri).thenReturn(Uri.parse('/some/path'));
      when(() => state.name).thenReturn('someRoute');

      final result = appRouterRedirect.handleRedirect(context, state);

      expect(result, null);
    });

    test('returns null when auth status is loading', () {
      when(() => authCubit.state).thenReturn(const AuthState(status: AuthStatus.loading, user: UserModel.empty()));
      when(() => state.uri).thenReturn(Uri.parse('/some/path'));
      when(() => state.name).thenReturn('someRoute');

      final result = appRouterRedirect.handleRedirect(context, state);

      expect(result, null);
    });

    group('authenticated', () {
      test('returns null when navigating to settings (public route) as CLIENT', () {
        const user = UserModel(role: RoleEnum.CLIENT);
        when(() => authCubit.state).thenReturn(const AuthState.authenticated(user, 'token'));
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.settings}'));
        when(() => state.name).thenReturn(AppRouteNames.settings);

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('redirects to index when role is CLIENT and attempting to access guestOnly route (Login)', () {
        const user = UserModel(role: RoleEnum.CLIENT);
        when(() => authCubit.state).thenReturn(const AuthState.authenticated(user, 'token'));
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.login}'));
        when(() => state.name).thenReturn(AppRouteNames.login);

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, '/');
      });

      test('returns null when role is CLIENT and on client route', () {
        const user = UserModel(role: RoleEnum.CLIENT);
        when(() => authCubit.state).thenReturn(const AuthState.authenticated(user, 'token'));
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.clientTourDetails}'));
        when(() => state.name).thenReturn(AppRouteNames.clientTourDetails);
        when(() => state.pathParameters).thenReturn({'tourId': '123'});

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('redirects to access-denied when role is CLIENT and accessing partner route', () {
        const user = UserModel(role: RoleEnum.CLIENT);
        when(() => authCubit.state).thenReturn(const AuthState.authenticated(user, 'token'));
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.partner}'));
        when(() => state.name).thenReturn(AppRouteNames.partner);

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, '/${AppRouteNames.accessDenied}');
      });

      test('returns null when role is PARTNER and on partner route', () {
        const user = UserModel(role: RoleEnum.PARTNER);
        when(() => authCubit.state).thenReturn(const AuthState.authenticated(user, 'token'));
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.partner}'));
        when(() => state.name).thenReturn(AppRouteNames.partner);

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('redirects to access-denied when role is PARTNER and accessing client route', () {
        const user = UserModel(role: RoleEnum.PARTNER);
        when(() => authCubit.state).thenReturn(const AuthState.authenticated(user, 'token'));
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.clientBookingDetails}'));
        when(() => state.name).thenReturn(AppRouteNames.clientBookingDetails);

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, '/${AppRouteNames.accessDenied}');
      });
    });

    group('unauthenticated (GUEST)', () {
      test('returns null when on guestOnly route (Login)', () {
        when(() => authCubit.state).thenReturn(const AuthState.unauthenticated());
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.login}'));
        when(() => state.name).thenReturn(AppRouteNames.login);

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('returns null when on public route (Settings)', () {
        when(() => authCubit.state).thenReturn(const AuthState.unauthenticated());
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.settings}'));
        when(() => state.name).thenReturn(AppRouteNames.settings);

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('redirects to login when accessing authenticated route (partner)', () {
        when(() => authCubit.state).thenReturn(const AuthState.unauthenticated());
        when(() => state.uri).thenReturn(Uri.parse('/${AppRouteNames.partner}'));
        when(() => state.name).thenReturn(AppRouteNames.partner);

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, AppRouteNames.login);
      });
    });
  });
}
