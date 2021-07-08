import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_share/pages/post_page.dart';
import 'package:memory_share/widgets/longButton.dart';

class SubEpisodePage extends StatefulWidget {
  @override
  _SubEpisodePageState createState() => _SubEpisodePageState();
}

class _SubEpisodePageState extends State<SubEpisodePage> {

  final picker = ImagePicker();

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

  // ignore: deprecated_member_use
  final _list = List<String>();
  int a=0;

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
              onPressed: () => {Navigator.pop(context),Navigator.pop(context)}
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    // return AlertDialog(
    //     title: Text("タイトル"),
    //     content: Text("メッセージメッセージメッセージメッセージメッセージメッセージ"),
    //     actions: <Widget>[
          // ボタン領域
          // FlatButton(
          //   child: Text("Cancel"),
          //   onPressed: () => Navigator.pop(context),
          // ),
          // FlatButton(
          //   child: Text("OK"),
          //   onPressed: () => Navigator.pop(context),
          // ),
        // ],

     return WillPopScope(
    //   ignore: missing_return
       onWillPop:(){
         if(_list.length>0){
           _showAlertDialog(context);
         }else{
         Navigator.of(context).pop();
         }
         },
    child:Scaffold(
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
      body:Stack(children:[
        ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final item = _list[index];
          return Dismissible(
            key: Key(item),

            onDismissed: (direction) {
              setState(() {
                _list.removeAt(index);
              });

              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text('$item dismissed')));
            },

            background: Container(color: Colors.red),

            child: ListTile(title: Text('$item')),

          );}
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
              longButton("エピソードを追加する",() => {
                setState(() {
                  _list.add(
                      'Item ${a}'
                  );
                  a++;
                })
              })
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              margin: EdgeInsets.only(bottom: 22),
              child:
              longButton("目的地に到着",() => onTapArriveButton(context))
          ),
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Container(
              // margin: EdgeInsets.only(right: 22),
              // child:
              // IconButton(
              //   icon: Icon(Icons.remove),
              //   onPressed: () {
              //     if (_list.length == 0) {
              //
              //     } else {
              //       setState(() {
              //         _list.removeAt(_list.length - 1);
              //       });
              //     }
              //   },
              // )
          // ),
        // ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: EdgeInsets.only(top: 22),
              child:(_list.length == 0) ? Image.asset('assets/hukura.jpg') : Text(" "),
          ),
        ),
      ]),
      )
    );
  }
}