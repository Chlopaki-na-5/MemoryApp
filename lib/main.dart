import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory app',
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const MyHomePage(title: 'Memory App'),
    );
  }
}
