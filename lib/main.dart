import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'lock_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppLocker',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name != null && settings.name!.startsWith('/lock')) {
          // Extract packageName from the route
          final uri = Uri.parse(settings.name!);
          final packageName = uri.queryParameters['packageName'] ?? '';
          return MaterialPageRoute(
            builder: (context) => LockScreen(packageName: packageName),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
        );
      },
    );
  }
}