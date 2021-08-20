import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/view_models/app_model/app_model.dart';
import 'add_sub_episode_view_model.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddSubEpisodePage extends StatelessWidget {
  const AddSubEpisodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();
    return ChangeNotifierProvider(
      create: (_) => AddSubEpisodeViewModel(),
      child: Consumer<AddSubEpisodeViewModel>(
        builder: (context, addSubEpisodeViewModel, _) => Scaffold(
          appBar: EditorAppBar(
            postLabel: "追加する",
            onPost: () {
              postViewModel.addSubEpisode(addSubEpisodeViewModel.subEpisode);
              Navigator.of(context).pop();
            },
            onCancel: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO_REVERSED,
                borderSide: const BorderSide(color: Colors.green, width: 2),
                width: 480,
                buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                headerAnimationLoop: false,
                animType: AnimType.BOTTOMSLIDE,
                title: '入力中の文章は全て消えます',
                desc: '本当に戻りますか',
                showCloseIcon: true,
                btnOkText: "はい",
                btnCancelText: "いいえ",
                btnCancelOnPress: () => {},
                btnOkOnPress: () {
                  Navigator.pop(context);
                  postViewModel.clearSubEpisode();
                },
              ).show();
            },
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Insert your message",
                    ),
                    scrollPadding: const EdgeInsets.all(20.0),
                    keyboardType: TextInputType.multiline,
                    maxLines: 99999,
                    autofocus: true,
                    controller: addSubEpisodeViewModel.textEditingController,
                    onChanged: (String text) => addSubEpisodeViewModel.onChanged(text),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
