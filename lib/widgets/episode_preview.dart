import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

class EpisodePreview extends StatelessWidget {
  const EpisodePreview(this.episodeText, {Key? key}) : super(key: key);

  final String episodeText;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
