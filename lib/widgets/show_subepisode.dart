import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:memory_share/widgets/widgets.dart';

class ShowSubEpisode extends StatefulWidget {
  final String SubEpisode;
  const ShowSubEpisode({
    Key key,
    this.SubEpisode,
  }) : super(key: key);

  @override
   ShowSubEpisodeState createState() =>  ShowSubEpisodeState();
}

class ShowSubEpisodeState extends State <ShowSubEpisode> {

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

  contentBox(context) {
    return SubEpisodeWrapper(widget.SubEpisode);
  }
}