import 'package:flutter/material.dart';

class PasswordPage extends StatelessWidget {

  const PasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("change_password"),
      ),
      body: const Center(),
    );
  }
}
