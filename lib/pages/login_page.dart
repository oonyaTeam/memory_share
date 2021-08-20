import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/view_models/login_view_model.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  void _showCustomToast() {
    FToast fToast = FToast();
    fToast.showToast(
      child: toast(),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2)
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(AuthRepository()),
      child: Consumer<LoginViewModel>(
        builder: (context, loginViewModel, _) => Scaffold(
          appBar: appBarComponent("Login"),
          body: Column(
            children: [
              textBox(Icons.email_outlined, "Email", loginViewModel.changeEmail),
              textBox(Icons.https_outlined, "Password", loginViewModel.changePassword),
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
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                ),
                child: const Text("SignUp"),
              ),
              TextButton(
                onPressed: () => {
                  _showCustomToast()
                },
                child: const Text("toast test"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
