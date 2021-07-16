import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddSubEpisodePage extends StatefulWidget {
  const AddSubEpisodePage({Key key}) : super(key: key);

  @override
  _AddSubEpisodePageState createState() => _AddSubEpisodePageState();
}

class _AddSubEpisodePageState extends State<AddSubEpisodePage> {
  TextEditingController _textEditingController;

  String _subEpisode = '';

  void _onChanged(String text) {
    setState(() {
      _subEpisode = text;
    });
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserModel>();
    return Scaffold(
      appBar: EditorAppBar(
        postLabel: "追加する",
        onPost: () => {
          userModel.addSubEpisode(_subEpisode),
          Navigator.of(context).pop(),
        },
        onCancel: () => {
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
        btnOkOnPress: () => {
        Navigator.pop(context),
        userModel.clearSubEpisode(),
        },
        ).show()
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
                controller: _textEditingController,
                onChanged: (String text) => _onChanged(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
