import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/face_id/presentation/screens/app_screen.dart';
import 'package:myapp/features/face_id/presentation/screens/docs_screen.dart';
import 'package:myapp/features/face_id/presentation/screens/my_ids_screen.dart';


class AppRouter {
  static const String splashRoute = '/';
  static const String faceIdListRoute = '/faceIdList';
  static const String docsRoute = '/docs';
  static const String appRoute = '/app';

  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,
    routes: [
      // GoRoute(
      //   path: splashRoute,
      //   builder: (context, state) => const SplashScreen(),
      // ),
      GoRoute(
        path: faceIdListRoute,
        builder: (context, state) => const MyIdsScreen(),
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