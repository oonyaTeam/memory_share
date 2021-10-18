import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:memory_share/widgets/widgets.dart';

class SubEpisodeDialog extends StatelessWidget {
  final String subEpisode;
  const SubEpisodeDialog(this.subEpisode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return SubEpisodeWrapper(subEpisode,onPressed: (){});
  }
}
