import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'episode_view_model.dart';

class EpisodeViewPage extends StatelessWidget {
  const EpisodeViewPage(this.currentMemory, {Key? key}) : super(key: key);

  final Memory currentMemory;

  @override
  Widget build(BuildContext context) {
    try {
      return ChangeNotifierProvider(
        create: (_) =>
            EpisodeViewModel(context: context, currentMemory: currentMemory),
        child: Consumer<EpisodeViewModel>(
          builder: (context, episodeViewModel, _) => Scaffold(
            body: Stack(
              children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: FutureBuilder<void>(
                    future: episodeViewModel.initializeCameraController,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Transform.scale(
                        scale: episodeViewModel.controller!.value.aspectRatio,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio:
                                episodeViewModel.controller!.value.aspectRatio,
                            child: CameraPreview(episodeViewModel.controller!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: EpisodePreview(
                    episodeViewModel.episodeText,
                    visible: episodeViewModel.showDialogFlag,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FloatingIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                  ),
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
