import 'package:flutter/material.dart';
import 'package:memory_share/models/MapModel.dart';
import 'package:memory_share/models/UserModel.dart';
import 'package:memory_share/pages/home_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {

  static const MaterialColor customSwatch = const MaterialColor(
    0xFFE9674B,
    const <int, Color>{
      50: const Color(0xFFFCEDE9),
      100: const Color(0xFFF8D1C9),
      200: const Color(0xFFF4B3A5),
      300: const Color(0xFFF09581),
      400: const Color(0xFFEC7E66),
      500: const Color(0xFFE9674B),
      600: const Color(0xFFE65F44),
      700: const Color(0xFFE3543B),
      800: const Color(0xFFDF4A33),
      900: const Color(0xFFD93923),
    },
  );
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserModel>(create: (_) => UserModel()),
        ChangeNotifierProvider<MapModel>(create: (_) => MapModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: customSwatch,
        ),
        home: HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}