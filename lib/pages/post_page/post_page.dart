import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/utils/toast.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: EditorAppBar(
        postLabel: "投稿する",
        onPost: () async {
          await postViewModel.postMemory().then((memory) {
            context.read<UserModel>().addMyMemories(memory);
            showCustomToast(context, '投稿しました', true);
            Navigator.of(context).popUntil((route) => route.isFirst);
          }).catchError(
            (e) => {showCustomToast(context, '投稿に失敗しました', false)},
          );
        },
        onCancel: () => AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO_REVERSED,
          borderSide: const BorderSide(color: Colors.green, width: 2),
          width: 480,
          buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          title: 'このページを離れますか？',
          desc: '「はい」を押すと、文章と写真は削除されます。}',
          showCloseIcon: true,
          btnOkText: "はい",
          btnCancelText: "いいえ",
          btnCancelOnPress: () => {},
          btnOkOnPress: () => {
            Navigator.pop(context),
          },
        ).show(),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Container(
                width: 375,
                height: 188,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(postViewModel.photo),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 200),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Insert your message",
                ),
                scrollPadding: const EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,
                onChanged: (String mainEpisode) =>
                    postViewModel.setMainEpisode(mainEpisode),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
