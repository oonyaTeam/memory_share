import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

class SubEpisodeWrapper extends StatelessWidget {
  const SubEpisodeWrapper(this.subEpisode, {Key? key, this.onPressed}) : super(key: key);

  final String subEpisode;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: CustomColors.pale,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          Row(
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
          if(onPressed != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                IconButton(
                  onPressed:onPressed,
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: CustomColors.primary,
                    size: 40.0,
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
