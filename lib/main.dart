import 'package:flutter/material.dart';
import 'package:tourism_app_flutter/screen/detail/detail_screen.dart';
import 'package:tourism_app_flutter/screen/home/home_screen.dart';
import 'package:tourism_app_flutter/screen/main/main_screen.dart';
import 'package:tourism_app_flutter/static/NavigationRoute.dart';

import 'model/tourism.dart';
import 'style/theme/tourism_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tourism App',
      theme: TourismTheme.lightTheme,
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          tourism: ModalRoute.of(context)?.settings.arguments as Tourism,
        ),
      },
    );
  }
}