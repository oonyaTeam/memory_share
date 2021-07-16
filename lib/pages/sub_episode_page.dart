import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SubEpisodePage extends StatelessWidget {

  SubEpisodePage({Key key}) : super(key: key);

  final picker = ImagePicker();

  Future _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final userModel = context.read<UserModel>();
        return AlertDialog(
          title: const Text('サブエピソードが残っています'),
          content: const Text('ホームに戻るとサブエピソードは全て消えます'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('いいえ'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('はい'),
              onPressed: () => {
                Navigator.pop(context),
                Navigator.pop(context),
                userModel.clearSubEpisode(),
              }, //TODO　なんか動いた
            ),
          ],
        );
      },
    );
  }

  Future onTapAddButton(BuildContext context) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddSubEpisodePage()));
  }

  Future onTapArriveButton(BuildContext context) async {
    final takenPhoto = await picker.getImage(source: ImageSource.camera);

    if (takenPhoto != null) {
      File photoFile = File(takenPhoto.path);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostPage(photo: photoFile),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();
    return WillPopScope(
      onWillPop: () async {
        if (userModel.subEpisodeList.isNotEmpty) {
          //_showAlertDialog(context);
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
            btnCancelOnPress: () => {},
            btnOkOnPress: () => {
              Navigator.pop(context),
              userModel.clearSubEpisode(),
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
        body: Stack(
          children: [
            ListView.builder(
              itemCount: userModel.subEpisodeList.length,
              itemBuilder: (context, index) {
                final item = userModel.subEpisodeList[index];
                return Dismissible(
                  key: Key(item),
                  onDismissed: (direction) {
                    userModel.removeSubEpisode(index);
                  },
                  background: Container(color: Colors.red),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        title: Text(
                          item,
                          style: const TextStyle(fontSize: 22.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
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
            // Column(
            //   children: [
            //     Expanded(
            //       child: ListView.builder(
            //         itemCount: _list.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return Card(
            //             child: Padding(
            //               child: Text('$index', style: TextStyle(fontSize: 22.0),textAlign: TextAlign.center,),
            //               padding: EdgeInsets.all(100.0)
            //             ),
            //           );
            //
            //           // return _list[index];
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 89),
                  child:
                      longButton("エピソードを追加する", () => onTapAddButton(context))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 22),
                  child:
                      longButton("目的地に到着", () => onTapArriveButton(context))),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(right: 22),
                child: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (userModel.subEpisodeList.isEmpty) {
                    } else {
                      userModel.removeSubEpisode(
                          userModel.subEpisodeList.length - 1);
                    }
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 22),
                child: (userModel.subEpisodeList.isEmpty)
                    ? Image.asset('assets/hukura.jpg')
                    : const Text(" "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
