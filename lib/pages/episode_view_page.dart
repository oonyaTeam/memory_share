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

  @override
  void initState() {
    super.initState();
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
      body: CameraPreview(controller),
    );
  }
}
