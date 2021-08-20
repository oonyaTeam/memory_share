import 'package:flutter/material.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:memory_share/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AddressPage extends StatelessWidget {

  const AddressPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Change_mail"),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child:
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: signInUpButton(
                  'Sign in',
                      () {},
                ),
              ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child:
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: googleTwitterButton(
                'Sign  in  with\n     Google',
                    () {},
                newTheme().googleRed,
                'assets/Logo white.svg'
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child:
            Container(
              margin: const EdgeInsets.only(top: 180),
              child: googleTwitterButton(
                  'Sign  in  with\n     Twitter',
                      () {},
                  newTheme().twitterBlue,
                  'assets/Logo white.svg'
                ),
              ),
            ),
        ],
      )
    );
  }
}