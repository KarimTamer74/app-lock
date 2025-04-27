import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/face_id/presentation/screens/face_id_list_screen.dart';
import '../../features/docs/presentation/screens/docs_screen.dart';
import '../../features/app/presentation/screens/app_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String faceIdListRoute = '/faceIdList';
  static const String docsRoute = '/docs';
  static const String appRoute = '/app';

  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,
    routes: [
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: faceIdListRoute,
        builder: (context, state) => const FaceIdListScreen(),
      ),
      GoRoute(
        path: docsRoute,
        builder: (context, state) => const DocsScreen(),
      ),
      GoRoute(
        path: appRoute,
        builder: (context, state) => const AppScreen(),
      ),
    ],
  );
}