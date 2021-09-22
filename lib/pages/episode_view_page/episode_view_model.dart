import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:memory_share/models/models.dart';

enum AngleMode {
  normal,
  minOverflow,
  maxOverflow,
}

class EpisodeViewModel with ChangeNotifier {
  final PostRepository _postRepository = PostRepository();

  List<CameraDescription> cameras = [];
  Future<void>? _initializeCameraController;
  CameraController? _controller;
  StreamSubscription? _compassStream;
  AngleMode _angleMode = AngleMode.normal;
  String _episodeText = "";
  bool _showDialogFlag = false;
  int _currentId = 0;
  double _memoryMinAngle = 0;
  double _memoryMaxAngle = 0;
  double _angle = 0;

  CameraController? get controller => _controller;

  Future<void>? get initializeCameraController => _initializeCameraController;

  String get episodeText => _episodeText;

  bool get showDialogFlag => _showDialogFlag;

  double get memoryMinAngle => _memoryMinAngle;

  double get memoryMaxAngle => _memoryMaxAngle;

  double get angle => _angle;

  EpisodeViewModel({
    required BuildContext context,
    required Memory currentMemory,
  }) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft, //横固定
    ]);

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        getCamera(context);
        getCompass();
        timer.cancel();
      }
    });

    setAngleAndEpisode(
        context: context,
        currentMemory: currentMemory,
        setAngle: currentMemory.angle);
  }

  Future<void> getCamera(BuildContext context) async {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      _initializeCameraController = _controller!.initialize();
    }
    notifyListeners();
  }

  void getCompass() {
    _compassStream = FlutterCompass.events!.listen((value) {
      if (value.heading == null) return;

      _angle = value.heading!;

      observeAngle(_angleMode);

      notifyListeners();
    });
  }

  void setAngleAndEpisode({
    required BuildContext context,
    required Memory currentMemory,
    required double setAngle,
  }) {
    final angle = setAngle;
    _episodeText = currentMemory.memory;
    _currentId = currentMemory.id;

    //angleの範囲が0〜360なのでそれに対応するための処理
    if (angle - 30 < 0) {
      _memoryMinAngle = 360 + (angle - 30);
      _memoryMaxAngle = angle + 30;
      _angleMode = AngleMode.minOverflow;
    } else if (angle + 30 > 360) {
      _memoryMinAngle = angle - 30;
      _memoryMaxAngle = (angle + 30) - 360;
      _angleMode = AngleMode.maxOverflow;
    } else if (angle - 30 > 0 && angle + 30 < 360) {
      _memoryMinAngle = angle - 30;
      _memoryMaxAngle = angle + 30;
      _angleMode = AngleMode.normal;
    }

    notifyListeners();
  }

  void observeAngle(AngleMode mode) {
    switch (mode) {
      case AngleMode.normal:
        if (_angle >= _memoryMinAngle && _angle <= _memoryMaxAngle) {
          _showDialogFlag = true;
        } else {
          _showDialogFlag = false;
        }
        break;
      case AngleMode.minOverflow:
        if (_angle >= 0 && _angle <= _memoryMaxAngle) {
          _showDialogFlag = true;
        } else if (_angle >= _memoryMinAngle && _angle <= 360) {
          _showDialogFlag = true;
        } else {
          _showDialogFlag = false;
        }
        break;
      case AngleMode.maxOverflow:
        if (_angle >= _memoryMinAngle && _angle <= 360) {
          _showDialogFlag = true;
        } else if (_angle >= 0 && _angle <= _memoryMaxAngle) {
          _showDialogFlag = true;
        } else {
          _showDialogFlag = false;
        }
        break;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    if (_showDialogFlag) {
      _postRepository.seenMemoryId(id: _currentId);
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, //縦固定
    ]);

    _controller?.dispose();
    _compassStream?.cancel();
    super.dispose();
  }
}
