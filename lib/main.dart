import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter x Dart Porfolio',
      debugShowCheckedModeBanner: false,

      // Light Theme (Sky Blue background)
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          255,
          255,
          255,
        ), // 👈 Sky blue bg
      ),

      // Dark Theme (default dark background)
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          161,
          160,
          160,
        ), // 👈 Dark bg
      ),

      themeMode: _themeMode,
      home: HomePage(onToggleTheme: toggleTheme, themeMode: _themeMode),
    );
  }
}
