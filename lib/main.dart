import 'package:flutter/material.dart';

import 'view/HomePage/HomePage.dart';
import 'view/HomePage/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        'Home': (context) => HomePage(),
      },
    );
  }
}
