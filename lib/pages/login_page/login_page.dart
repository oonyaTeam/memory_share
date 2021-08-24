import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(AuthRepository()),
      child: Consumer<LoginViewModel>(
        builder: (context, loginViewModel, _) => Scaffold(
          body: Column(
            children: [
              // margin取るためにラップ email
              Container(
                child: emailPasswordBox(
                  iconData: Icons.email_outlined,
                  topText: "Email",
                  onChanged: loginViewModel.changeEmail,
                  width: MediaQuery.of(context).size.width
                ),
                margin: const EdgeInsets.only(top: 24),
              ),
              // margin取るためにラップ password
              Container(
                child: emailPasswordBox(
                  iconData: Icons.https_outlined,
                  topText: "Password",
                  onChanged: loginViewModel.changePassword,
                  width: MediaQuery.of(context).size.width,
                ),
                margin: const EdgeInsets.only(top: 16),
              ),
              // margin取るためにラップ sign inボタン
              Container(
                child: signInUpButton(
                  "Sign in",
                  () async {
                    await loginViewModel.loginWithEmailAndPassword().then((_) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    }).catchError((e) {});
                  },
                  MediaQuery.of(context).size.width
                ),
                margin: const EdgeInsets.only(top: 32, bottom: 32),
              ),
              Text(
                "または",
                style: TextStyle(
                    fontSize: 12,
                    color: newTheme().deep
                ),
              ),
              // twitter,googleのボタンを横並びさせるためにラップ
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width - 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    googleTwitterButton(
                      'Sign  in  with\n     Google',
                        () async {
                        await loginViewModel.loginWithGoogle().then((_) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        }).catchError((e) {});
                      },
                      newTheme().googleRed,
                      'assets/google.svg',
                      MediaQuery.of(context).size.width,
                    ),
                    googleTwitterButton(
                      'Sign  in  with\n     Twitter',
                          () async {
                        await loginViewModel.loginWithTwiiter().then((_) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        }).catchError((e) {});
                      },
                      newTheme().twitterBlue,
                      'assets/twitter.svg',
                      MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
              // 横並びするためにラップ
              Container(
                margin: const EdgeInsets.only(top: 64),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "アカウントを持っていない？",
                      style: TextStyle(
                        fontSize: 12,
                        color: newTheme().deep
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      ),
                      child: const Text("SignUp"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
