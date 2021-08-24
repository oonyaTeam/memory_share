import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class EpisodeViewModel with ChangeNotifier {
  List<CameraDescription> cameras;
  Future<void> _initializeCameraController;
  CameraController _controller;
  StreamSubscription _compassStream;
  bool _showDialogFlag;
  double _angle;

  CameraController get controller => _controller;

  Future<void> get initializeCameraController => _initializeCameraController;

  bool get showDialogFlag => _showDialogFlag;

  double get angle => _angle;

  EpisodeViewModel() {
    _showDialogFlag = true;

    getCamera();
    getCompass();
  }

  Future<void> getCamera() async {
    cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    _initializeCameraController = _controller.initialize();
    notifyListeners();
  }

  void getCompass() {
    _compassStream = FlutterCompass.events.listen((value) {
      _angle = value.heading;

      notifyListeners();
    });
  }

  void _showEpisodeDialog({
    @required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("えもい"),
          content: const Text("えもいねえ"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('back'),
              onPressed: () {
                //Navigator.pop(context);
                _showDialogFlag = true;
              },
            ),
          ],
        );
      },
    );
  }

  void huntingEpisode({
    @required BuildContext context,
  }) {
    if (_angle >= 100.0 && _angle <= 110.0 && _showDialogFlag) {
      _showEpisodeDialog(context: context);
      _showDialogFlag = false;
      //print("えもい");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _compassStream?.cancel();
    super.dispose();
  }
}