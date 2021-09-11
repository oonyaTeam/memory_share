import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

  Future<bool> initialize(BuildContext context) async {
    await context.read<UserModel>().initialize();
    final bool permission = await context.read<UserModel>().checkPermission();
    return permission;
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
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MaterialApp(
                home: Splash(),
              );
            }

            if (!snapshot.hasData) {
              return const MaterialApp(
                home: Scaffold(
                  body: Text("snapshot don't has Data"),
                ),
              );
            }

            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: primary,
                textTheme:
                    GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme),
              ),
              color: Colors.white,
              // ログインしていない（currentUserがnull）ならLoginPageに遷移。
              //　`reExperienceTutorialDone == null` は、[UserModel]でコンストラクタ内の非同期処理が完了するのを待っています。
              home: context.read<UserModel>().currentUser != null
                  ? context.read<UserModel>().reExperienceTutorialDone!
                      ? snapshot.data! // 位置情報の権限が許可されているかどうか
                          ? const HomePage()
                          : const AskPermissionPage()
                      : const ReExperienceTutorialPage()
                  : const LoginPage(),
            );
          },
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

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
