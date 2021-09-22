import 'package:flutter/material.dart';

class SubEpisodeMarker extends StatelessWidget {
  const SubEpisodeMarker(this.number, {Key? key}) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12.0, bottom: 28.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: Image.asset('assets/sub_episode_marker.png').image,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
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
      padding: const EdgeInsets.only(top: 12.0, bottom: 28.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: Image.asset('assets/sub_episode_invalid_marker.png').image,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
