import 'package:flutter/material.dart';
import 'package:memory_share/widgets/widgets.dart';

class AddressPage extends StatelessWidget {

  const AddressPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Change_mail"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child:
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: signInUpButton(
              'Sign in',
                  () {},
            ),
          ),
      )
    );
  }
}