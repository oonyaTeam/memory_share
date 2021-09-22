import 'package:flutter/material.dart';

class SubEpisodeMarker extends StatelessWidget {
  const SubEpisodeMarker(this.number, {Key? key}) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/sub_episode_marker.png').image,
        ),
      ),
      child: Center(
        child: Text(number.toString()),
      ),
    );
  }
}

class SubEpisodeInvalidMarker extends StatelessWidget {
  const SubEpisodeInvalidMarker(this.number, {Key? key}) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/sub_episode_invalid_marker.png').image,
        ),
      ),
      child: Center(
        child: Text(number.toString()),
      ),
    );
  }
}
