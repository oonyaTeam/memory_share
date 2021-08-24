import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:memory_share/models/entities/entities.dart';

class EpisodeViewModel with ChangeNotifier{

  List<CameraDescription> cameras;
  Future<void> _initializeCameraController;
  CameraController _controller;

  String _compass = "no data";
  List<String> _compassData;
  bool dialogFlag = true;

  CameraController get controller => _controller;
  Future<void> get initializeCameraController => _initializeCameraController;

  EpisodeViewModel() {
    //Timer.periodic(const Duration(milliseconds: 1000), _onTimer);
    getCamera();
  }

  Future<void> getCamera() async{
    cameras = await availableCameras();
    final firstCamera = cameras.first;
    print(firstCamera);
    print(firstCamera);
    /*
    availableCameras().then((cameras) {
      _controller = CameraController(cameras[0], ResolutionPreset.max);
    });

     */
    _controller = CameraController(firstCamera,ResolutionPreset.max);
    /*
    availableCameras().then((cameras) {

      _controller.initialize();
    });
    
     */

    _initializeCameraController = _controller.initialize();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
    notifyListeners();
  }
}