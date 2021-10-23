import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_share/widgets/widgets.dart';

class Tutorial2Page extends StatelessWidget {
  const Tutorial2Page({
    required this.page,
    required this.notifier,
    Key? key,
  }) : super(key: key);

  final int page;
  final ValueNotifier<double> notifier;

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      notifier: notifier,
      page: page,
      child: TutorialTemplate(
        content: SvgPicture.asset(
          'assets/tutorial/tutorial_reexperience_2.svg',
          width: 329.0,
          height: 231.0,
        ),
        text: 'サブエピソードに近づくと\n投稿者がその場所で感じていた思いを\n見ることができる',
      ),
    );
  }
}
