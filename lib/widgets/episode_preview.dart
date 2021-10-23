import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

class EpisodePreview extends StatelessWidget {
  const EpisodePreview(this.episodeText, {required this.visible, Key? key})
      : super(key: key);

  final String episodeText;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: visible ? 1.0 : 0,
      child: Container(
        color: CustomColors.light.withOpacity(0.8),
        margin: const EdgeInsets.fromLTRB(80, 0, 80, 0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(episodeText),
            ],
          ),
        ),
      ),
    );
  }
}
