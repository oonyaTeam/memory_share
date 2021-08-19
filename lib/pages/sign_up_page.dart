import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/view_models/sign_up_view_model.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
                const SizedBox(
                  height: 50,
                ),
                const Text("Email"),
                TextField(
                  onChanged: (text) => signUpViewModel.changeEmail(text),
                ),
                const Text("Password"),
                TextField(
                  obscureText: true,
                  onChanged: (text) => signUpViewModel.changePassword(text),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await signUpViewModel.signUpWithEmailAndPassword().then((_) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()),
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
