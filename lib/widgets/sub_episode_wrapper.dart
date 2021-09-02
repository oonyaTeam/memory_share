import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

class SubEpisodeWrapper extends StatelessWidget {
  const SubEpisodeWrapper(this.subEpisode, {Key key}) : super(key: key);

  final String subEpisode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: CustomColors.pale,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: const Icon(
              Icons.sticky_note_2_outlined,
              size: 40.0,
              color: CustomColors.primary,
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
