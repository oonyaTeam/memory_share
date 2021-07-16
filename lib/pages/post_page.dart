import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class PostPage extends StatelessWidget {
  final File photo;

  const PostPage({Key key, this.photo}) : super(key: key);

  Future post(BuildContext context) async {
    // API処理を書く
    // とりあえず、home_pageへの画面遷移だけ書いておく
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

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
    final userModel = context.watch<UserModel>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: EditorAppBar(
        postLabel: "投稿する",
        onPost: () => post(context),
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
                    image: FileImage(photo),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 200),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Insert your message",
                ),
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
