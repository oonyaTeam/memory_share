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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 11,),
            longButton("エピソードを追加する",() => {}),
            SizedBox(height: 11,),
            longButton("目的地に到着",() => onTapArriveButton(context))
          ],
        ),
      ),
    );
  }
}