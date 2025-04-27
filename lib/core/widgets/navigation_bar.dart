import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_router.dart';
import '../utils/constants.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentRoute;

  const CustomNavigationBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _calculateSelectedIndex(context),
      onTap: (int idx) => _onItemTapped(idx, context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'My IDs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description_outlined),
          label: 'Docs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud_outlined),
          label: 'App',
        ),
      ],
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.grey,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = currentRoute;
    if (location.startsWith(AppRouter.faceIdListRoute)) {
      return 0;
    }
    if (location.startsWith(AppRouter.docsRoute)) {
      return 1;
    }
    if (location.startsWith(AppRouter.appRoute)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(AppRouter.faceIdListRoute);
        break;
      case 1:
        GoRouter.of(context).go(AppRouter.docsRoute);
        break;
      case 2:
        GoRouter.of(context).go(AppRouter.appRoute);
        break;
    }
  }
}