import 'package:flutter/material.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:memory_share/models/models.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginModel>(
      builder: (context, loginModel, _) {
        return Scaffold(
          appBar: appBarComponent("Login"),
          body: Column(
            children: [
              const SizedBox(height: 50,),
              const Text("Email"),
              TextField(
                onChanged: (text) => loginModel.changeEmail(text),
              ),
              const Text("Password"),
              TextField(
                obscureText: true,
                onChanged: (text) => loginModel.changePassword(text),
              )
            ],
          ),
        );
      },
    );
  }
}
