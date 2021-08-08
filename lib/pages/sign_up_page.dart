import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, authModel, _) {
        return Scaffold(
          appBar: appBarComponent("SignUp"),
          body: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("Email"),
              TextField(
                onChanged: (text) => authModel.changeEmail(text),
              ),
              const Text("Password"),
              TextField(
                obscureText: true,
                onChanged: (text) => authModel.changePassword(text),
              ),
              ElevatedButton(
                onPressed: () async {
                  await authModel.signUpWithEmailAndPassword();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
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
    );
  }
}
