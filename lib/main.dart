import 'package:flutter/material.dart';

import 'providers/book_provider.dart';
import 'screens/book_list_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BookProvider _bookProvider = BookProvider();

  @override
  void dispose() {
    _bookProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF356859);
    return MaterialApp(
      title: 'Tủ sách của tôi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandColor,
          surface: const Color(0xFFF8F8F3),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F8F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F8F3),
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFE9EAE3)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E3DA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E3DA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: brandColor, width: 1.5),
          ),
        ),
      ),
      home: const LoginScreen(),
      routes: {
        BookListScreen.routeName: (context) =>
            BookListScreen(bookProvider: _bookProvider),
      },
    );
  }
}
