import 'package:flutter/material.dart';
import 'package:myapp/lock_screen.dart';
import 'package:myapp/main_screen.dart';

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
      routes: {
        '/': (context) => const MainScreen(),
        '/lock': (context) => LockScreen(
          packageName: ModalRoute.of(context)!.settings.arguments as String,
        ),
      },
    );
  }
}