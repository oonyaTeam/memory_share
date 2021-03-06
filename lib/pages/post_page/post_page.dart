import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/change_image_dialog.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'post_page_view_model.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  /// 投稿するをタップすると、投稿を行う。投稿に成功すると、Toastを表示してhomeに戻る
  /// 失敗したら、Toastを表示する。
  void _onSubmit({
    required BuildContext context,
    required PostViewModel model,
  }) async {
    await model.postMemory().then((_) {
      showCustomToast(context, '投稿しました', true);
      Navigator.of(context).popUntil((route) => route.isFirst);
      model.clearNewPost();
    }).catchError((e) {
      showCustomToast(context, '投稿に失敗しました', false);
    });
  }

  /// 画像を変更するダイアログを表示する
  void _showChangeImageDialog({
    required BuildContext context,
    required PostViewModel model,
  }) {
    showDialog(
      context: context,
      builder: (context) => ChangeImageDialog(
        imageFile: model.photo!,
        onSubmitted: () {
          _reTakeImage(model: model);
          Navigator.pop(context);
        },
        onCanceled: () => Navigator.pop(context),
      ),
    );
  }

  /// 写真を取り直す
  void _reTakeImage({
    required PostViewModel model,
  }) async =>
      await model.takeMainEpisodeImage();

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();
    return ChangeNotifierProvider(
      create: (_) => PostPageViewModel(),
      child: Consumer<PostPageViewModel>(builder: (context, model, _) {
        return WillPopScope(
          onWillPop: () async {
            model.unfocusTextField();
            final willPop = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  wid: MediaQuery.of(context).size.width,
                  descriptions: "写真とエピソードが\n削除されますが\nよろしいですか？",
                  onSubmitted: () {
                    Navigator.pop(context, true);
                    postViewModel.clearMainEpisode();
                  },
                  onCanceled: () {
                    Navigator.pop(context, false);
                    model.focusTextField();
                  },
                );
              },
            );
            return willPop ?? false;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: CustomScrollView(
              controller: model.controller,
              slivers: [
                CustomSliverAppBar(
                  controller: model.controller,
                  title: '思い出を投稿',
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: VariableColorButton(
                        label: '投稿する',
                        onPressed: postViewModel.mainEpisode == ''
                            ? null
                            : () => _onSubmit(
                                  context: context,
                                  model: postViewModel,
                                ),
                        width: 118.0,
                        height: 48.0,
                        primary: CustomColors.primary,
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    GestureDetector(
                      onTap: () => _showChangeImageDialog(
                        context: context,
                        model: postViewModel,
                      ),
                      child: Container(
                        width: 375,
                        height: 188,
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(postViewModel.photo!),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "思い出を書こう",
                      ),
                      scrollPadding: const EdgeInsets.all(20.0),
                      keyboardType: TextInputType.multiline,
                      maxLines: 20,
                      autofocus: true,
                      focusNode: model.textFieldFocusNode,
                      onChanged: (String mainEpisode) =>
                          postViewModel.mainEpisode = mainEpisode,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
