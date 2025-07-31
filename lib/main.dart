import 'package:flutter/material.dart';
import 'package:serene/pages/home_page.dart';
import 'global/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Serene',
      theme: globalTheme,
      home: const HomePage(),
    );
  }
}
