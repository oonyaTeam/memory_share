import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memory_share/widgets/widgets.dart';

import 'episode_view_model.dart';

class EpisodeViewPage extends StatelessWidget {
  const EpisodeViewPage({Key key}) : super(key: key);

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
                RotatedBox(
                  quarterTurns: 3,
                  child: FutureBuilder<void>(
                    future: episodeViewModel.initializeCameraController,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return RotatedBox(
                          quarterTurns: 3,
                          child: Transform.scale(
                            scale: episodeViewModel.controller.value.aspectRatio,
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: episodeViewModel.controller.value.aspectRatio,
                                child: CameraPreview(episodeViewModel.controller),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: episodeViewModel.showDialogFlag
                      ? episodePreview(episodeText: "えもいねぇ")
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
