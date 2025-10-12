import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@immutable
final class AppRouter {
  const AppRouter._({required this.isNewUser, required this.role});

  factory AppRouter.intance({required bool isNewUser, required bool role}) =>
      AppRouter._(isNewUser: isNewUser, role: role);

  final bool isNewUser;
  final bool role;

  GoRouter router() {
    return GoRouter(
      initialLocation: isNewUser ? '/' : '/home',
      navigatorKey: navigatorKey,
      debugLogDiagnostics: kDebugMode,
      routes: [
      ]
    );
  }

  static List<RouteBase> get _clientRoutes {
    return [];
  }

  static List<RouteBase> get _partnerRoutes {
    return [];
  }
}
