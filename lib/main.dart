import 'package:biblioteque/screens/first_screen.dart';
import 'package:biblioteque/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: FirstScreen(),
      ),
    );
  }
}
