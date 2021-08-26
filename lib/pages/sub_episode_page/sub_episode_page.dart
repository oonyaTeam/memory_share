import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SubEpisodePage extends StatelessWidget {
  SubEpisodePage({Key key}) : super(key: key);

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
    // if (context.read<UserModel>().postTutorialDone) return;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PostTutorialPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial(context));

    return WillPopScope(
      onWillPop: () async {
        if (postViewModel.subEpisodeList.isNotEmpty) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO_REVERSED,
            borderSide: const BorderSide(color: Colors.green, width: 2),
            width: 480,
            buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
            headerAnimationLoop: false,
            animType: AnimType.BOTTOMSLIDE,
            title: 'サブエピソードが残っています',
            desc: 'ホームに戻るとサブエピソードは全て消えます',
            showCloseIcon: true,
            btnOkText: "はい",
            btnCancelText: "いいえ",
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              Navigator.pop(context);
              postViewModel.clearSubEpisode();
            },
          ).show();
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
            ListView.builder(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
              itemCount: postViewModel.subEpisodeList.length,
              itemBuilder: (context, index) {
                final item = postViewModel.subEpisodeList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubEpisodeWrapper(subEpisode: item.episode),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 24.0),
                      child: SvgPicture.asset(
                        'assets/foot_prints.svg',
                        height: 80.0,
                        width: 40.0,
                        color: newTheme().pale,
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
                child: longButton(
                  "エピソードを追加する",
                  () => onTapAddButton(context),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 89),
                child: longButton("エピソードを追加する", () => onTapAddButton(context)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 22),
                child: longButton(
                  "目的地に到着",
                  () => onTapArriveButton(context),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 22),
                child: (postViewModel.subEpisodeList.isEmpty)
                    ? Image.asset('assets/normal.png')
                    : const Text(""),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
