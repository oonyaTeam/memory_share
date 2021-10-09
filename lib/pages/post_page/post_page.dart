import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'post_page_view_model.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  void onSubmit({
    required BuildContext context,
    required PostViewModel model,
  }) async {
    await model.postMemory().then((_) {
      showCustomToast(context, '投稿しました', true);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }).catchError((e) {
      showCustomToast(context, '投稿に失敗しました', false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();
    return ChangeNotifierProvider(
      create: (_) => PostPageViewModel(),
      child: Consumer<PostPageViewModel>(builder: (context, model, _) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: EditorAppBar(
            postLabel: "投稿する",
            onPost: () async {
              await postViewModel.postMemory().then((_) {
                showCustomToast(context, '投稿しました', true);
                Navigator.of(context).popUntil((route) => route.isFirst);
              }).catchError((e) {
                showCustomToast(context, '投稿に失敗しました', false);
              });
            },
            onCancel: () {
              model.unfocusTextField();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    wid: MediaQuery.of(context).size.width,
                    descriptions: "写真とエピソードが\n削除されますが\nよろしいですか？",
                    onSubmitted: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    onCanceled: () {
                      Navigator.pop(context);
                      model.focusTextField();
                    },
                  );
                },
              );
            },
            primary: (postViewModel.mainEpisode == "")
                ? CustomColors.deep
                : CustomColors.primary,
          ),
          body: CustomScrollView(
            controller: model.controller,
            slivers: [
              CustomSliverAppBar(
                controller: model.controller,
                title: '思い出を投稿',
                actions: [
                  VariableColorButton(
                    label: '投稿する',
                    onPressed: postViewModel.mainEpisode == ''
                        ? null
                        : () => onSubmit(
                              context: context,
                              model: postViewModel,
                            ),
                    width: 114.0,
                    height: 44.0,
                    primary: CustomColors.primary,
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  GestureDetector(
                    onTap: () {},
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
                    maxLines: 99999,
                    autofocus: true,
                    focusNode: model.textFieldFocusNode,
                    onChanged: (String mainEpisode) =>
                        postViewModel.setMainEpisode(mainEpisode),
                  ),
                ]),
              ),
            ],
          ),
        );
      }),
    );
  }
}
