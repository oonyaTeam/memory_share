import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_share/theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: 24.0,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 24.0),
              child: SvgPicture.asset(
                'assets/normal.svg',
                height: 180.0,
                width: 180.0,
              ),
            ),
            const Text(
              "思い出の場所へ到着するまでに\n思い出したエピソードを書きましょう。\n到着したら、思い出の場所の写真を撮ります。",
              style: TextStyle(
                color: CustomColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                height: 1.15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
