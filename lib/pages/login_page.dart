import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, authModel, _) {
        return Scaffold(
          appBar: appBarComponent("Login"),
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
                  await authModel.loginWithEmailAndPassword();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                ),
                child: const Text("SignUp"),
              ),
            ],
          ),
        );
      },
    );
  }
}
