import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class EpisodeViewPage extends StatefulWidget {
  const EpisodeViewPage({Key key}) : super(key: key);

  @override
  _EpisodeViewPageState createState() => _EpisodeViewPageState();
}

class _EpisodeViewPageState extends State<EpisodeViewPage> {
  CameraController controller;
  String _compass = "no data";
  int a = 0;

  Future<void> getCompass() async {
    final CompassEvent compass = await FlutterCompass.events.first;
    setState(() {
      _compass = compass.toString();
    });
  }

  void _onTimer(Timer timer) {
    getCompass();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(milliseconds: 10),
        _onTimer
    );
    availableCameras().then((cameras) {
      controller = CameraController(cameras[0], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {

        });
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("EpisodeViewPage"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(_compass),
              CameraPreview(controller)
            ],
          ),
        )
    );
  }
}
