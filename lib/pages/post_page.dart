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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '思い出を投稿',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Episode',
                hintText: 'Episode',
              ),
            ),
            SizedBox(
              height: 11,
            ),
            longButton("投稿", () => {}),
            SizedBox(
              height: 11,
            ),
            Image.file(widget.photo),
          ],
        ),
      ),
    );
  }
}
