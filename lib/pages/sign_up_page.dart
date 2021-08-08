import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
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
                onPressed: () => authModel.signUpWithEmailAndPassword(),
                child: const Text("SignUp"),
              ),
            ],
          ),
        );
      },
    );
  }
}
