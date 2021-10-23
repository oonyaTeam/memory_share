import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_share/widgets/widgets.dart';

class Tutorial1Page extends StatelessWidget {
  const Tutorial1Page({
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
          'assets/tutorial/tutorial_post_1.svg',
          width: 289.0,
          height: 279.0,
        ),
        text: '自分の思い出の場所に向かいます',
      ),
    );
  }
}
