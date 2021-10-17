import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TutorialTemplate(
            content: Stack(
              children: [
                Image.asset('assets/circle_map.jpg'),
                Center(
                  child: Image.asset(
                    'assets/memory_spot_icon.png',
                    height: 96,
                    width: 96,
                  ),
                )
              ],
            ),
            text: '近くにあるアイコンをタップ！\n目的地に登録したら\nそこへ向かって歩いていく',
          ),
        ],
      ),
    );
  }
}
