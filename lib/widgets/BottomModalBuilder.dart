import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memory_share/pages/episode_view_page.dart';

// BottomModal（ReExperiencePage で下に画像等を表示するモーダル）

Widget BottomModalBuilder(
    {BuildContext context, double distance, double sigma}) {
  return Container(
    padding: EdgeInsets.only(top: 30.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("あと${distance}m"),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EpisodeViewPage()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ImageFiltered(
              child: Image.asset("assets/sample_image.jpg"),
              imageFilter: ImageFilter.blur(
                sigmaX: sigma,
                sigmaY: sigma,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
