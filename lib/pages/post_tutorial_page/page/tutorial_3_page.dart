import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:memory_share/widgets/widgets.dart';

class Tutorial3Page extends StatelessWidget {
  const Tutorial3Page({
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
        content: Container(),
        text: '思い出の場所についたら\n思い出の風景を写真に収めます',
      ),
    );
  }
}
