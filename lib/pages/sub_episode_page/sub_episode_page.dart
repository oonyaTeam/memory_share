import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

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

    if (takenPhoto != null) {
      File photoFile = File(takenPhoto.path);
      context.read<PostViewModel>().setPhoto(photoFile);
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
                  descriptions1: "エピソードが\n全て削除されますが\nよろしいですか？",
                  tapEvent1: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    postViewModel.clearSubEpisode();
                  },
                  tapEvent2: () {
                    Navigator.pop(context);
                  },
                );
              });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '思い出投稿',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            postViewModel.subEpisodeList.isEmpty
                ? Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                        top: 24.0,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 24.0),
                            child: SvgPicture.asset(
                              'assets/normal.svg',
                              height: 180.0,
                              width: 180.0,
                            ),
                          ),
                          const Text(
                            "思い出の場所へ到着するまでに\n思い出したエピソードを書きましょう。\n到着したら、思い出の場所の写真を撮ります。",
                            style: TextStyle(
                              color: CustomColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              height: 1.15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 16.0,
                    ),
                    itemCount: postViewModel.subEpisodeList.length,
                    itemBuilder: (context, index) {
                      final item = postViewModel.subEpisodeList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 89),
                child: LongButton(
                  label: "エピソードを追加する",
                  onPressed: () => onTapAddButton(context),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 22),
                child: LongButtonBorderPrimary(
                  label: "目的地に到着",
                  onPressed: () => onTapArriveButton(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
