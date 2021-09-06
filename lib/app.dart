import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static const MaterialColor primary = MaterialColor(
    0xFFF67280,
    <int, Color>{
      50: Color(0xFFF67280),
      100: Color(0xFFF67280),
      200: Color(0xFFF67280),
      300: Color(0xFFF67280),
      400: Color(0xFFF67280),
      500: Color(0xFFF67280),
      600: Color(0xFFF67280),
      700: Color(0xFFF67280),
      800: Color(0xFFF67280),
      900: Color(0xFFF67280),
    },
  );

  Future<void> initialize(BuildContext context) async {
    await context.read<UserModel>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /// アプリ全体（または複数の画面）で参照したいViewModelはここで宣言してる。
      /// その他、画面ごとのViewModelは、各画面で宣言してる。
      providers: [
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
        ChangeNotifierProvider<PostViewModel>(create: (_) => PostViewModel()),
      ],
      child: Builder(
        builder: (context) => FutureBuilder(
          future: initialize(context),
          builder: (context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MaterialApp(
                home: Splash(),
              );
            } else {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: primary,
                  textTheme: GoogleFonts.notoSansTextTheme(
                      Theme.of(context).textTheme),
                ),
                color: Colors.white,
                // ログインしていない（currentUserがnull）ならLoginPageに遷移。
                //　`reExperienceTutorialDone == null` は、[UserModel]でコンストラクタ内の非同期処理が完了するのを待っています。
                home: context.read<UserModel>().currentUser != null
                    ? const HomePage()
                    : const LoginPage(),
              );
            }
          },
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/sample_splash.png"),
      ),
    );
  }
}
