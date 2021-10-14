import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  /// 次の画面に遷移する。命名は後で変えるかも
  Future<void> _routeNextPage(BuildContext context) async {
    final bool permission = await context.read<UserModel>().checkPermission();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          if (!context.read<UserModel>().reExperienceTutorialDone!) {
            return const ReExperienceTutorialPage();
          }
          if (permission) {
            return const HomePage();
          } else {
            return const AskPermissionPage();
          }
        },
      ),
    );
  }

  void _onSubmitLogin(BuildContext context, LoginViewModel model) async {
    try {
      await model.loginWithEmailAndPassword();
      showCustomToast(context, 'ログインに成功しました', true);
      await _routeNextPage(context);
    } on FirebaseAuthException catch (e) {
      Validator.firebaseAuthLoginValidate(context: context, message: e.code);
    }
  }

  void _onSubmitGoogleLogin(BuildContext context, LoginViewModel model) async {
    await model.loginWithGoogle();
    await _routeNextPage(context);
  }

  void _onSubmitTwitterLogin(BuildContext context, LoginViewModel model) async {
    await model.loginWithTwitter();
    await _routeNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(AuthRepository()),
      child: Consumer<LoginViewModel>(
        builder: (context, loginViewModel, _) => Scaffold(
          backgroundColor: CustomColors.primary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // 上のSign inってとこをラップ
                Container(
                  alignment: Alignment.topLeft,
                  // 480が白いところのheight, 36はSign inのtextのheight
                  margin: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height - 480 - 36) / 2,
                    left: 24,
                    bottom: (MediaQuery.of(context).size.height - 480 - 36) / 2,
                  ),
                  child: Text(
                    "Sign in",
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ),
                // そっから下のところ全部をラップ
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      // margin取るためにラップ email
                      Container(
                        child: EmailPasswordBox(
                          iconData: Icons.email_outlined,
                          label: "Email",
                          onChanged: loginViewModel.changeEmail,
                          width: MediaQuery.of(context).size.width,
                        ),
                        margin: const EdgeInsets.only(top: 24),
                      ),
                      // margin取るためにラップ password
                      Container(
                        child: EmailPasswordBox(
                          iconData: Icons.https_outlined,
                          label: "Password",
                          onChanged: loginViewModel.changePassword,
                          width: MediaQuery.of(context).size.width,
                        ),
                        margin: const EdgeInsets.only(top: 16),
                      ),
                      // margin取るためにラップ sign inボタン
                      Container(
                        child: SignInUpButton(
                          label: "Sign in",
                          onPressed: () =>
                              _onSubmitLogin(context, loginViewModel),
                          width: MediaQuery.of(context).size.width,
                        ),
                        margin: const EdgeInsets.only(top: 32, bottom: 32),
                      ),
                      const Text(
                        "または",
                        style: TextStyle(
                          fontSize: 12,
                          color: CustomColors.deep,
                          height: 1.0,
                        ),
                      ),
                      // twitter,googleのボタンを横並びさせるためにラップ
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        width: MediaQuery.of(context).size.width - 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GoogleTwitterButton(
                              label: 'Sign  in  with\n     Google',
                              assetName: 'assets/google.svg',
                              onPressed: () =>
                                  _onSubmitGoogleLogin(context, loginViewModel),
                              screenWidth: MediaQuery.of(context).size.width,
                              color: CustomColors.googleRed,
                            ),
                            GoogleTwitterButton(
                              label: 'Sign  in  with\n     Twitter',
                              assetName: 'assets/twitter.svg',
                              onPressed: () => _onSubmitTwitterLogin(
                                  context, loginViewModel),
                              screenWidth: MediaQuery.of(context).size.width,
                              color: CustomColors.twitterBlue,
                            ),
                          ],
                        ),
                      ),
                      // 横並びするためにラップ
                      Container(
                        margin: const EdgeInsets.only(top: 32, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "アカウントを持っていない？",
                              style: TextStyle(
                                fontSize: 12,
                                color: CustomColors.deep,
                                height: 1.0,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              ),
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: CustomColors.primary,
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
