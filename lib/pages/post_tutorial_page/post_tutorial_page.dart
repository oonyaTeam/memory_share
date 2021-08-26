import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:memory_share/theme.dart';
import 'package:provider/provider.dart';

import 'page/tutorial_1_page.dart';
import 'page/tutorial_2_page.dart';
import 'post_tutorial_view_model.dart';

class PostTutorialPage extends StatelessWidget {
  const PostTutorialPage({Key key}) : super(key: key);

  Widget _getTutorialPage(int index, PostTutorialViewModel model) {
    switch (index % 2) {
      case 0:
        model.changeNotifier(0);
        return Tutorial1Page(page: index, notifier: model.notifier);
      case 1:
        return Tutorial2Page(page: index, notifier: model.notifier);
      default:
        throw ArgumentError("範囲外です");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostTutorialViewModel(),
      child: Consumer<PostTutorialViewModel>(builder: (context, model, _) {
        final PageController _pageController = PageController();
        return Scaffold(
          body: Center(
            child: Stack(
              children: [
                AnimatedBackgroundColor(
                  child: PageView(
                    controller: _pageController,
                    children: List<Widget>.generate(
                      model.pageCount,
                      (index) => _getTutorialPage(index, model),
                    ),
                  ),
                  colors: model.colors,
                  pageController: _pageController,
                  pageCount: model.pageCount,
                ),
                Align(
                  alignment: const Alignment(0, 0.85),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 0.94),
                  child: SlidingIndicator(
                    indicatorCount: model.pageCount,
                    notifier: model.notifier,
                    activeIndicator: Icon(
                      Icons.check_circle,
                      color: newTheme().pale,
                    ),
                    inActiveIndicator: Container(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
