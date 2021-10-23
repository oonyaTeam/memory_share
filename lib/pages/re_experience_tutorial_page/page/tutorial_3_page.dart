import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_share/widgets/widgets.dart';

class Tutorial3Page extends StatelessWidget {
  const Tutorial3Page({
    required this.page,
    required this.notifier,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final int page;
  final ValueNotifier<double> notifier;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      notifier: notifier,
      page: page,
      child: TutorialTemplate(
        content: SvgPicture.asset(
          'assets/tutorial/tutorial_reexperience_3.svg',
          width: 400.0,
          height: 201.0,
        ),
        text: '目的地に着いたらカメラを開いて\nスマホを写真の方にかざすと\n投稿者の思い出のエピソードを\nみることができます',
        onPressed: onTap,
      ),
    );
  }
}
