import 'package:flutter/material.dart';
import 'dart:developer';
import '../widgets/longButton.dart';

class PostPage extends StatefulWidget {
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
        child: Column(
          children: [
            SizedBox(height: 11,),
            longButton("エピソードを追加する",() => {}),
            SizedBox(height: 11,),
            longButton("目的地に到着",() => {})
          ],
        ),
      ),
    );
  }
}

