import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';

class EpisodeViewModel with ChangeNotifier {
  List<CameraDescription> cameras = [];
  Future<void>? _initializeCameraController;
  CameraController? _controller;
  StreamSubscription? _compassStream;
  bool _showDialogFlag = false;
  double _angle = 0;

  CameraController? get controller => _controller;

  Future<void>? get initializeCameraController => _initializeCameraController;

  bool get showDialogFlag => _showDialogFlag;

  double get angle => _angle;

  EpisodeViewModel() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft, //横固定
    ]);

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

    _initializeCameraController = _controller!.initialize();
    notifyListeners();
  }

  void getCompass() {
    _compassStream = FlutterCompass.events!.listen((value) {
      if (value.heading == null) return;

      _angle = value.heading!;

      if (_angle >= 0.0 && _angle <= 360.0) {
        _showDialogFlag = true;
      } else {
        _showDialogFlag = false;
      }

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _compassStream?.cancel();
    super.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, //縦固定
    ]);
  }
}
