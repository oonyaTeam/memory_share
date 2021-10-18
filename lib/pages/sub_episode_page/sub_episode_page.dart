import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'empty_state.dart';
import 'sub_episode_view_model.dart';

class SubEpisodePage extends StatelessWidget {
  const SubEpisodePage({Key? key}) : super(key: key);

  /// サブエピソードを追加するボタンをタップしたときの処理
  Future onTapAddButton(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddSubEpisodePage()),
    );
  }

  /// 到着したときの処理
  Future<void> onTapArriveButton(BuildContext context) async {
    context.read<SubEpisodeViewModel>().isLoading = true;

    try {
      await context.read<PostViewModel>().takeMainEpisodeImage();
    } catch (e) {
      context.read<SubEpisodeViewModel>().isLoading = false;
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PostPage(),
      ),
    );
    context.read<SubEpisodeViewModel>().isLoading = false;
  }

  void _showTutorial(BuildContext context) {
    if (context.read<UserModel>().postTutorialDone!) return;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PostTutorialPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _showTutorial(context));

    return WillPopScope(
      onWillPop: () async {
        if (postViewModel.subEpisodeList.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                wid: MediaQuery.of(context).size.width,
                descriptions: "エピソードが\n全て削除されますが\nよろしいですか？",
                onSubmitted: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  postViewModel.clearSubEpisode();
                },
                onCanceled: () {
                  Navigator.pop(context);
                },
              );
            },
          );
          return false;
        } else {
          return true;
        }
      },
      child: ChangeNotifierProvider(
        create: (_) => SubEpisodeViewModel(),
        child: Consumer<SubEpisodeViewModel>(builder: (context, model, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Builder(builder: (context) {
              if (model.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Stack(
                children: [
                  CustomScrollView(
                    controller: model.controller,
                    slivers: [
                      CustomSliverAppBar(
                        controller: model.controller,
                        title: "思い出を投稿",
                      ),
                      if (postViewModel.subEpisodeList.isEmpty)
                        SliverList(
                          delegate: SliverChildListDelegate([
                            const EmptyState(),
                          ]),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            left: 24.0,
                            right: 24.0,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                // SubEpisodeを逆（新しいものを上）にして表示するために、配列の後ろから表示
                                final i = postViewModel.subEpisodeList.length -
                                    index -
                                    1;
                                final item = postViewModel.subEpisodeList[i];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SubEpisodeWrapper(item.episode),
                                    Row(
                                      children: [
                                        SubEpisodeWrapper(item.episode,
                                            onPressed:(){
                                          postViewModel.removeSubEpisode(index);
                                        }),
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8.0,
                                                left: 24.0,
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/foot_prints.svg',
                                                height: 80.0,
                                                width: 40.0,
                                                color: CustomColors.pale,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              childCount: postViewModel.subEpisodeList.length,
                            ),
                          ),
                        ),
                      // SliverList(delegate: (delegate))
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 89),
                      child: LongButton(
                        label: "エピソードを書く",
                        onPressed: () => onTapAddButton(context),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 22),
                      child: LongButtonBorderPrimary(
                        label: "写真を撮る",
                        onPressed: () => onTapArriveButton(context),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        }),
      ),
    );
  }
}
