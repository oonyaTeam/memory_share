import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/pages/re_experience_page/re_experience_view_model.dart';

// BottomModal（ReExperiencePage で下に画像等を表示するモーダル）
Widget bottomModalBuilder({
  required BuildContext context,
  required ReExperienceViewModel model,
}) {
  return Container(
    padding: const EdgeInsets.only(top: 30.0),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("あと${model.distance}m"),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EpisodeViewPage()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ImageFiltered(
              child: Image.network(model.currentMemory.image),
              imageFilter: ImageFilter.blur(
                sigmaX: model.distance / 100,
                sigmaY: model.distance / 100,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
