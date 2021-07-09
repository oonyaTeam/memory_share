import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class PasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("change_password"),
        ),
        body:
        Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AnimatedButton(
                    text: 'A W E S O M E D I A L O G',
                    pressEvent: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO_REVERSED,
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        width: 480,
                        buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                        headerAnimationLoop: false,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'サブエピソードが残っています！',
                        desc: '''ページを移動すると消えてしまいます！
本当に移動しますか？''',
                        showCloseIcon: true,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}