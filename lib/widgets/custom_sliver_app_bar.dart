import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';
import 'package:provider/provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar(
      {required this.controller, required this.title, this.actions, Key? key})
      : super(key: key);

  final String title;
  final ScrollController controller;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomSliverAppBarNotifier(controller),
      child: Consumer<CustomSliverAppBarNotifier>(builder: (context, model, _) {
        return SliverAppBar(
          expandedHeight: 112.0,
          backgroundColor: Colors.white,
          foregroundColor: CustomColors.primary,
          iconTheme: const IconThemeData(color: CustomColors.primary),
          pinned: true,
          snap: false,
          floating: true,
          flexibleSpace: FlexibleSpaceBar.createSettings(
            currentExtent: 0,
            child: FlexibleSpaceBar(
              titlePadding: EdgeInsetsDirectional.only(
                start: model.titleStartPadding,
                bottom: 12,
              ),
              title: const Text(
                'これまでの投稿',
                style: TextStyle(
                  color: CustomColors.primary,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          actions: actions,
        );
      }),
    );
  }
}

class CustomSliverAppBarNotifier with ChangeNotifier {
  CustomSliverAppBarNotifier(this._controller) {
    // タイトルの位置を、paddingを変更することで、動的に変更している。
    _controller.addListener(() {
      titleStartPadding = min(16 + _controller.offset, titleStartMaxPadding);

      notifyListeners();
    });
  }

  // タイトルの左のPaddingの最大値
  static const double titleStartMaxPadding = 72.0;

  final ScrollController _controller;

  // タイトルの左のPadding
  double titleStartPadding = 16.0;

  ScrollController get controller => _controller;
}
