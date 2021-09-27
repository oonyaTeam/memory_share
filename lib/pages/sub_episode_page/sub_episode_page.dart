import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/pages/sub_episode_page/empty_state.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/custom_sliver_app_bar.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'sub_episode_view_model.dart';

class SubEpisodePage extends StatelessWidget {
  SubEpisodePage({Key? key}) : super(key: key);

  final picker = ImagePicker();

  Future onTapAddButton(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddSubEpisodePage()),
    );
  }

  Future onTapArriveButton(BuildContext context) async {
    final takenPhoto = await picker.pickImage(source: ImageSource.camera);
    final CompassEvent compassData = await FlutterCompass.events!.first;
    final double angle = double.parse(compassData.heading.toString());

    if (takenPhoto != null) {
      File photoFile = File(takenPhoto.path);
      context.read<PostViewModel>().setPhoto(photoFile);
      context.read<PostViewModel>().setAngle(angle);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PostPage(),
        ),
      );
    }
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
              });
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
            body: Stack(
              children: [
                CustomScrollView(
                  controller: model.controller,
                  slivers: [
                    CustomSliverAppBar(
                      controller: model.controller,
                      title: "思い出を投稿",
                    ),
                    postViewModel.subEpisodeList.isEmpty
                        ? SliverList(
                            delegate: SliverChildListDelegate([
                              const EmptyState(),
                            ]),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              left: 24.0,
                              right: 24.0,
                            ),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final item =
                                      postViewModel.subEpisodeList[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SubEpisodeWrapper(item.episode),
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
            ),
          );
        }),
      ),
    );
  }
}
