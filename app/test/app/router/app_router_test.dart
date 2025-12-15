import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/app/router/app_router_redirect.dart';
import 'package:app/app/router/app_routes.dart';
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

    test('returns / when auth status is initial', () {
      when(() => authCubit.state).thenReturn(const AuthState.initial());
      when(() => state.uri).thenReturn(Uri.parse('/some/path'));

      final result = appRouterRedirect.handleRedirect(context, state);

      expect(result, '/');
    });

    test('returns / when auth status is failure', () {
      when(() => authCubit.state).thenReturn(const AuthState.failure('error'));
      when(() => state.uri).thenReturn(Uri.parse('/some/path'));

      final result = appRouterRedirect.handleRedirect(context, state);

      expect(result, '/');
    });

    group('authenticated', () {
      test('returns null when navigating to settings (global route)', () {
        when(() => authCubit.state).thenReturn(const AuthState.authenticated( 'token'));
        when(() => state.uri).thenReturn(Uri.parse(AppRoutes.settings));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('redirects to client home when role is CLIENT and not on client route', () {
        when(() => authCubit.state).thenReturn(const AuthState.authenticated( 'token'));
        when(() => state.uri).thenReturn(Uri.parse('/some/other/path'));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, AppRoutes.client);
      });

      test('returns null when role is CLIENT and on client route', () {
        when(() => authCubit.state).thenReturn(const AuthState.authenticated('token'));
        when(() => state.uri).thenReturn(Uri.parse(AppRoutes.clientTourDetailsPath('123')));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('redirects to partner home when role is PARTNER and not on partner route', () {
        when(() => authCubit.state).thenReturn(const AuthState.authenticated( 'token'));
        when(() => state.uri).thenReturn(Uri.parse('/some/other/path'));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, AppRoutes.partner);
      });

      test('returns null when role is PARTNER and on partner route', () {
        when(() => authCubit.state).thenReturn(const AuthState.authenticated( 'token'));
        when(() => state.uri).thenReturn(Uri.parse('${AppRoutes.partner}/${AppRoutes.partnerCreateTour}'));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });
    });

    group('unauthenticated', () {
      test('redirects to initial settings when onboarding not complete and not on initial settings', () {
        when(() => authCubit.state).thenReturn(const AuthState.unauthenticated(hasCompletedOnboarding: false));
        when(() => state.uri).thenReturn(Uri.parse('/some/other/path'));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, AppRoutes.initialSettings);
      });

      test('returns null when onboarding not complete and on initial settings', () {
        when(() => authCubit.state).thenReturn(const AuthState.unauthenticated(hasCompletedOnboarding: false));
        when(() => state.uri).thenReturn(Uri.parse(AppRoutes.initialSettings));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('redirects to login when onboarding complete and not on login', () {
        when(() => authCubit.state).thenReturn(const AuthState.unauthenticated(hasCompletedOnboarding: true));
        when(() => state.uri).thenReturn(Uri.parse('/some/other/path'));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, AppRoutes.login);
      });

      test('returns null when onboarding complete and on login', () {
        when(() => authCubit.state).thenReturn(const AuthState.unauthenticated(hasCompletedOnboarding: true));
        when(() => state.uri).thenReturn(Uri.parse(AppRoutes.login));

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, null);
      });

      test('redirects to login when onboarding complete and on a protected route', () {
        when(() => authCubit.state).thenReturn(const AuthState.unauthenticated(hasCompletedOnboarding: true));
        when(() => state.uri).thenReturn(Uri.parse(AppRoutes.client)); // A protected route

        final result = appRouterRedirect.handleRedirect(context, state);

        expect(result, AppRoutes.login);
      });
    });
  });
}
