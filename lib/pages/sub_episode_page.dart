import 'dart:io';

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

  // List<Color> colorList = [Colors.cyan, Colors.deepOrange, Colors.indigo];

  List<Text> _list = [
    Text(
      "初期値",
      style: TextStyle(fontSize: 20),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  return _list[index];
                },
              ),
            ),



            // IconButton(
            //   icon: Icon(Icons.add),
            //   onPressed: () {
            //     setState(() {
            //       _list.add(
            //         Text(
            //           "テキスト" + _list.length.toString(),
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       );
            //     });
            //   },
            // ),

          ],
        ),

        // ListView.builder(
        //   itemCount: 12,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Container(
        //       height: 80,
        //       color: colorList[index % colorList.length],
        //       child: Text('こんにちわ'),
        //     );
        //   },
        // ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Container(
        //     margin: EdgeInsets.only(bottom: 89),
        //     child:
        //       longButton("エピソードを追加する",() => {})
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              margin: EdgeInsets.only(bottom: 89),
              child:
              longButton("エピソードを追加する",() => {
                setState(() {
                  _list.add(
                    Text(
                      "テキスト" + _list.length.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  );
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
        Align(
          alignment: Alignment.topRight,
          child: Container(
              margin: EdgeInsets.only(right: 22),
              child:
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (_list.length == 1) {
                    ;
                  } else {
                    setState(() {
                      _list.removeAt(_list.length - 1);
                    });
                  }
                },
              )
          ),
        ),
      ]),
    );
  }
}