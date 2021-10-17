import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubEpisodeMarker extends StatelessWidget {
  const SubEpisodeMarker(this.number, {Key? key}) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.0,
      width: 72.0,
      child: Stack(
        children: [
          Image.asset(
            'assets/sub_episode_marker.png',
            fit: BoxFit.fill,
          ),
          Align(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Text(
                number.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
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
