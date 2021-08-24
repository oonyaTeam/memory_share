import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';

import 'episode_view_model.dart';

/*
class EpisodeViewPage extends StatefulWidget {
  const EpisodeViewPage({Key key}) : super(key: key);

  @override
  _EpisodeViewPageState createState() => _EpisodeViewPageState();
}

class _EpisodeViewPageState extends State<EpisodeViewPage> {
  CameraController controller;
  String _compass = "no data";
  List<String> _compassData;
  bool dialogFlag = true;

  Future<void> _getCompass() async {
    final CompassEvent compass = await FlutterCompass.events.first;
    double heading = 0.0;

    if (!mounted) return;

    setState(() {
      _compassData = compass.toString().split("\n");
      _compass = _compassData[0].substring(8);
    });

    heading = double.parse(_compass);
    if (heading >= 100.0 && heading <= 110.0 && dialogFlag) {
      _showAlertDialog(context);
      dialogFlag = false;
    }
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Episode'),
          content: const Text('エモいねえ'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('back'),
              onPressed: () {
                Navigator.pop(context);
                dialogFlag = true;
              },
            ),
          ],
        );
      },
    );
  }

  void _onTimer(Timer timer) {
    _getCompass();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 1000), _onTimer);
    availableCameras().then((cameras) {
      controller = CameraController(cameras[0], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
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
    try {
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
              CameraPreview(controller)
            ],
          ),
        ),
      );
    } on NoSuchMethodError {
      return Container();
    }
  }
}
*/

class EpisodeViewPage extends StatelessWidget {
  final CameraDescription camera;

  const EpisodeViewPage({Key key, @required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return ChangeNotifierProvider(
        create: (_) => EpisodeViewModel(),
        child: Consumer<EpisodeViewModel>(
          builder: (context, episodeViewModel, _) => Scaffold(
            appBar: appBarComponent("EpisodeView Page"),
            /*
            body: !(episodeViewModel.controller.value.isInitialized)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CameraPreview(episodeViewModel.controller),

             */
            body: FutureBuilder<void>(
              future: episodeViewModel.initializeCameraController,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.done){
                  return CameraPreview(episodeViewModel.controller);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      );
    } on NoSuchMethodError {
      return Container();
    }
  }
}
