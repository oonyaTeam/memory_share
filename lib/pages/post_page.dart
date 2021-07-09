import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memory_share/widgets/widgets.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key, this.photo}) : super(key: key);

  final File photo;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Stack(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 0),
                child:
                TextButton(
                  onPressed: () {},
                  child: Text('キャンセル'),
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              //margin: EdgeInsets.all(0.0),
              child:
              VariableButton("投稿する", () => {}, 114.0, 44.0),
            ),
          ),
        ],),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body:Stack(children:[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 5),
            child:
            Container(
              width: 375,
              height: 188,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(widget.photo),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 200),
            child:
            TextField(
              decoration: InputDecoration(hintText: "Insert your message",),
              scrollPadding: EdgeInsets.all(20.0),
              keyboardType: TextInputType.multiline,
              maxLines: 99999,
              autofocus: true)
          ),
        ),
      ]),
    );
  }
}