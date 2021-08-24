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
          appBar: appBarComponent("Login"),
          body: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              emailPasswordBox(
                iconData: Icons.email_outlined,
                topText: "Email",
                onChanged: loginViewModel.changeEmail,
              ),
              const SizedBox(
                height: 4,
              ),
              emailPasswordBox(
                iconData: Icons.https_outlined,
                topText: "Password",
                onChanged: loginViewModel.changePassword,
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () async {
                  await loginViewModel.loginWithEmailAndPassword().then((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }).catchError((e) {});
                },
                child: const Text("Login"),
              ),
              signInUpButton("Sign in", () => {}, MediaQuery.of(context).size.width),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                ),
                child: const Text("SignUp"),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: googleTwitterButton(
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
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: googleTwitterButton(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
