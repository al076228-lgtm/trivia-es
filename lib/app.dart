import 'package:flutter/material.dart';
import 'config/routes.dart';
import 'screens/home_screen.dart';
import 'screens/categories_screen.dart';

class TriviaApp extends StatelessWidget {
  const TriviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.categories: (context) => const CategoriesScreen(),
      },
    );
  }
}
