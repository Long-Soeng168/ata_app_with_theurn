import 'package:ata_app/models/favorite.dart';
import 'package:ata_app/pages/favorite_page.dart';
import 'package:ata_app/pages/intro_page.dart';
import 'package:ata_app/pages/home/home_page.dart';
import 'package:ata_app/pages/main_page.dart';
import 'package:ata_app/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Favorite(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: const IntroPage(),
      routes: {
        '/intro_page':(context) => const IntroPage(),
        '/main_page':(context) => const MainPage(),
        '/home_page':(context) => const HomePage(),
        '/favorite_page':(context) => const FavoritePage(),
      },
    );
  }
}