import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() {
  runApp(const BibliotecaApp());
}

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const bordo = Color(0xFF7B1E1E);
    const bege = Color(0xFFFBEED7);

    final theme = ThemeData(
      primaryColor: bordo,
      colorScheme: ColorScheme.fromSeed(seedColor: bordo, primary: bordo, secondary: bege),
      scaffoldBackgroundColor: bege,
      appBarTheme: const AppBarTheme(backgroundColor: bordo, foregroundColor: Colors.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: bordo),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: bordo, foregroundColor: Colors.white),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minha Biblioteca',
      theme: theme,
      home: const HomePage(),
    );
  }
}

