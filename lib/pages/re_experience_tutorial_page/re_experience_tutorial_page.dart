import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:provider/provider.dart';

import 'page/tutorial_1_page.dart';
import 'page/tutorial_2_page.dart';
import 're_experience_tutorial_view_model.dart';

class ReExperienceTutorialPage extends StatelessWidget {
  const ReExperienceTutorialPage({Key? key}) : super(key: key);

  static const _indicatorIconSize = 12.0;

  Widget _getTutorialPage(
    int index,
    ReExperienceTutorialViewModel model,
    BuildContext context,
  ) {
    switch (index % model.pageCount) {
      case 0:
        return Tutorial1Page(page: index, notifier: model.notifier);
      case 1:
        return Tutorial2Page(
          page: index,
          notifier: model.notifier,
          onTap: () => _onFinishTutorial(context),
        );
      default:
        throw ArgumentError("範囲外です");
    }
  }

  void _onFinishTutorial(BuildContext context) async {
    await context.read<UserModel>().reExperienceTutorialIsFinished();
    final bool isPermissionAllowed =
        await context.read<ReExperienceTutorialViewModel>().requestPermission();
    if (isPermissionAllowed) {
      // チュートリアルが終わったというbool値を保存する。
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      // 位置情報取得の権限が許可されなかったら、AskPermissionPageに飛ぶ
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AskPermissionPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReExperienceTutorialViewModel(),
      child: Consumer<ReExperienceTutorialViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            body: Center(
              child: Stack(
                children: [
                  AnimatedBackgroundColor(
                    child: PageView(
                      controller: model.pageController,
                      children: List<Widget>.generate(
                        model.pageCount,
                        (index) => _getTutorialPage(index, model, context),
                      ),
                    ),
                    colors: model.colors,
                    pageController: model.pageController,
                    pageCount: model.pageCount,
                  ),
                  Align(
                    alignment: const Alignment(0, 0.94),
                    child: SlidingIndicator(
                      indicatorCount: model.pageCount,
                      notifier: model.notifier,
                      activeIndicator: Container(
                        height: _indicatorIconSize,
                        width: _indicatorIconSize,
                        decoration: const BoxDecoration(
                          color: CustomColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      inActiveIndicator: Container(
                        height: _indicatorIconSize,
                        width: _indicatorIconSize,
                        decoration: const BoxDecoration(
                          color: CustomColors.light,
                          shape: BoxShape.circle,
                        ),
                      ),
                      activeIndicatorSize: _indicatorIconSize,
                      inactiveIndicatorSize: _indicatorIconSize,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
