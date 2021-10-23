import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:memory_share/widgets/widgets.dart';

class Tutorial4Page extends StatelessWidget {
  const Tutorial4Page({
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
        content: Container(),
        text: 'その場所であった出来事や\n思い出を記録しましょう',
        onPressed: onTap,
      ),
    );
  }
}
