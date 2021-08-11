import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String _memory = "";

  Future _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('このページを離れますか？'),
          content: const Text('「はい」を押すと、文章と写真は削除されます。'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('いいえ'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('はい'),
              onPressed: () => {
                Navigator.pop(context),
                Navigator.pop(context)
              }, //TODO　なんか動いた
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserModel>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: EditorAppBar(
        postLabel: "投稿する",
        onPost: () async {
          await userModel.postMemory(_memory).then(
              (_) => Navigator.of(context).popUntil((route) => route.isFirst))
          .catchError((e) => {});
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
          desc: '「はい」を押すと、文章と写真は削除されます。',
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
                    image: FileImage(userModel.photo),
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
                onChanged: (String memory) => setState(() {
                  _memory = memory;
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
