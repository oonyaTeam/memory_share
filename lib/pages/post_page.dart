import 'dart:io';

import 'package:flutter/material.dart';

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
        child: Image.file(widget.photo),
      ),
    );
  }
}
