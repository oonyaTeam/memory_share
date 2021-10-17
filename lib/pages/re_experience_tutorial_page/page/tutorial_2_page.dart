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
        content: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/circle_map.jpg',
                height: 295,
                width: 295,
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: SubEpisodeMarker(1),
            ),
            Align(
              child: SvgPicture.asset(
                'assets/current_position.svg',
                height: 20.0,
                width: 20.0,
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: SubEpisodeWrapper('そういえばブランコに乗ってよく幼馴染と話してたなあ'),
              ),
            ),
          ],
        ),
        text: 'サブエピソードに近づくと\n投稿者がその場所で感じていた思いを\n見ることができる',
      ),
    );
  }
}
