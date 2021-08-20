import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'sign_up_view_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(AuthRepository()),
      child: Consumer<SignUpViewModel>(
        builder: (context, signUpViewModel, _) {
          return Scaffold(
            appBar: appBarComponent("SignUp"),
            body: Column(
              children: [
                textBox(Icons.email_outlined, "Email", signUpViewModel.changeEmail),
                textBox(Icons.https_outlined, "Password", signUpViewModel.changePassword),
                ElevatedButton(
                  onPressed: () async {
                    await signUpViewModel.signUpWithEmailAndPassword().then((_) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    }).catchError((e) {});
                  },
                  child: const Text("SignUp"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  ),
                  child: const Text("Login"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
