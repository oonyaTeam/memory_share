import 'package:flutter/material.dart';
import 'package:memory_share/view_models/app_model/app_model.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'add_sub_episode_view_model.dart';

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
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return CustomDialogBox(
                      wid: MediaQuery.of(context).size.width,
                      descriptions1: "エピソードが\n削除されますが\nよろしいですか？",
                      tapEvent1: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      tapEvent2: (){
                        Navigator.pop(context);
                      },
                    );
                  }
              );
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
                    onChanged: (String text) =>
                        addSubEpisodeViewModel.onChanged(text),
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
