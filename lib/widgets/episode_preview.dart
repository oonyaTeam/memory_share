import 'package:flutter/material.dart';

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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white.withOpacity(0.8),
        padding: const EdgeInsets.only(left: 48, right: 48),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 64, bottom: 96),
            child: Text(
              episodeText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
