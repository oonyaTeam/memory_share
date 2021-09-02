import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';
import 'sign_up_view_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(AuthRepository()),
      child: Consumer<SignUpViewModel>(
          builder: (context, signUpViewModel, _) => Scaffold(
                backgroundColor: CustomColors.primary,
                body: Column(
                  children: [
                    // sign upをラップ
                    Container(
                      alignment: Alignment.topLeft,
                      // 480が白いところのheight, 36はSign upのtextのheight
                      margin: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height - 480 - 36) /
                              2,
                          left: 24,
                          bottom:
                              (MediaQuery.of(context).size.height - 480 - 36) /
                                  2),
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.montserrat(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.0),
                      ),
                    ),
                    // そっから下のところ全部をラップ(白いところ)
                    Container(
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
                            child: emailPasswordBox(
                                iconData: Icons.email_outlined,
                                topText: "Email",
                                onChanged: signUpViewModel.changeEmail,
                                width: MediaQuery.of(context).size.width),
                            margin: const EdgeInsets.only(top: 24),
                          ),
                          // margin取るためにラップ password
                          Container(
                            child: emailPasswordBox(
                              iconData: Icons.https_outlined,
                              topText: "Password",
                              onChanged: signUpViewModel.changePassword,
                              width: MediaQuery.of(context).size.width,
                            ),
                            margin: const EdgeInsets.only(top: 16),
                          ),
                          // margin取るためにラップ sign inボタン
                          Container(
                            child: signInUpButton("Sign in", () async {
                              await signUpViewModel
                                  .signUpWithEmailAndPassword()
                                  .then((_) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              }).catchError((e) {});
                            }, MediaQuery.of(context).size.width),
                            margin: const EdgeInsets.only(top: 32, bottom: 32),
                          ),
                          const Text(
                            "または",
                            style: TextStyle(
                                fontSize: 12,
                                color: CustomColors.deep,
                                height: 1.0),
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
                                      height: 1.0),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                  ),
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: CustomColors.primary,
                                        height: 1.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
