import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

class SubEpisodeWrapper extends StatelessWidget {
  const SubEpisodeWrapper({
    Key key,
    @required this.subEpisode,
  }) : super(key: key);

  final String subEpisode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: newTheme().pale,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.sticky_note_2_outlined,
              size: 40.0,
              color: newTheme().primary,
            ),
          ),
          Flexible(
            child: Text(
              subEpisode,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
