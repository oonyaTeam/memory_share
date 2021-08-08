import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);

  static const MaterialColor customSwatch = MaterialColor(
    0xFFE9674B,
    <int, Color>{
      50: Color(0xFFFCEDE9),
      100: Color(0xFFF8D1C9),
      200: Color(0xFFF4B3A5),
      300: Color(0xFFF09581),
      400: Color(0xFFEC7E66),
      500: Color(0xFFE9674B),
      600: Color(0xFFE65F44),
      700: Color(0xFFE3543B),
      800: Color(0xFFDF4A33),
      900: Color(0xFFD93923),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
        ChangeNotifierProvider<MapModel>(create: (_) => MapModel()),
        ChangeNotifierProvider<AuthModel>(create: (_) => AuthModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: customSwatch,
        ),
        home: const LoginPage(),
        // home: const HomePage(title: 'Home Page'),
      ),
    );
  }
}
