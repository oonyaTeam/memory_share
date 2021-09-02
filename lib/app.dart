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
        builder: (context) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: primary,
            textTheme:
                GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme),
          ),
          color: Colors.white,

          /// ログインしていない（currentUserがnull）ならLoginPageに遷移。
          ///　`reExperienceTutorialDone == null` は、[UserModel]でコンストラクタ内の非同期処理が完了するのを待っています。
          home: context.read<UserModel>().currentUser != null
              ? context.watch<UserModel>().reExperienceTutorialDone == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const HomePage()
              : const LoginPage(),
        ),
      ),
    );
  }
}
