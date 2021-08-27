import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

class Tutorial2Page extends StatelessWidget {
  const Tutorial2Page({
    this.page,
    this.notifier,
    this.onTap,
    Key key,
  }) : super(key: key);

  final int page;
  final ValueNotifier<double> notifier;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      notifier: notifier,
      page: page,
      child: Center(
        child: ElevatedButton(
          child: const Text("FINISH"),
          onPressed: () => onTap(),
        ),
      ),
    );
  }
}
