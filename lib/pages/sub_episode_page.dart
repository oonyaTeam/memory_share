import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SubEpisodePage extends StatelessWidget {
  final picker = ImagePicker();

  Future _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('サブエピソードが残っています'),
          content: Text('ホームに戻るとサブエピソードは全て消えます'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('いいえ'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('はい'),
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
        if (userModel.subEpisodeList.length > 0) {
          _showAlertDialog(context);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
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
                      padding: EdgeInsets.all(20.0),
                      child: ListTile(
                        title: Text(
                          '$item',
                          style: TextStyle(fontSize: 22.0),
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
                margin: EdgeInsets.only(bottom: 89),
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
                  margin: EdgeInsets.only(bottom: 89),
                  child:
                      longButton("エピソードを追加する", () => onTapAddButton(context))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(bottom: 22),
                  child:
                      longButton("目的地に到着", () => onTapArriveButton(context))),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 22),
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (userModel.subEpisodeList.length == 0) {
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
                margin: EdgeInsets.only(top: 22),
                child: (userModel.subEpisodeList.length == 0)
                    ? Image.asset('assets/hukura.jpg')
                    : Text(" "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
