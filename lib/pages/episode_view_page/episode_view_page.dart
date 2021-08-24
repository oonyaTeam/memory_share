import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';

import 'episode_view_model.dart';

class EpisodeViewPage extends StatelessWidget {
  const EpisodeViewPage({Key key}) : super(key: key);

  void _showEpisodeDialog({
    @required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("aaaaa"),
          content: const Text("aaaaaaaa"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return ChangeNotifierProvider(
        create: (_) => EpisodeViewModel(),
        child: Consumer<EpisodeViewModel>(
          builder: (context, episodeViewModel, _) => Scaffold(
            appBar: appBarComponent("EpisodeView Page"),
            body: Stack(
              children: [
                FutureBuilder<void>(
                  future: episodeViewModel.initializeCameraController,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(episodeViewModel.controller);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: episodeViewModel.showDialogFlag
                      ? Container(
                    color: Colors.white,
                    margin: const EdgeInsets.fromLTRB(40, 40, 30, 40),
                  )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      );
    } on NoSuchMethodError {
      return Container();
    }
  }
}