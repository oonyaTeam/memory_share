import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 're_experience_view_model.dart';

class ReExperiencePage extends StatelessWidget {
  const ReExperiencePage({
    Key? key,
    required this.currentMemory,
  }) : super(key: key);

  final Memory currentMemory;

  Widget _buildBottomSheet({
    required ReExperienceViewModel model,
    required BuildContext context,
  }) =>
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "残り"),
                    TextSpan(
                      text: "${model.distance}",
                      style: const TextStyle(fontSize: 24.0),
                    ),
                    const TextSpan(text: "m"),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ImageFiltered(
                child: MainEpisodeImage(
                  imageUrl: model.currentMemory.image,
                  height: 256,
                ),
                imageFilter: ImageFilter.blur(
                  sigmaX: model.sigma.toDouble(),
                  sigmaY: model.sigma.toDouble(),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReExperienceViewModel(currentMemory, context),
      child: Consumer<ReExperienceViewModel>(
        builder: (context, model, _) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            model.getMarkerBitmaps();
          });
          return Scaffold(
            body: Stack(
              children: [
                /// 画面の外で、サブエピソードを描画している。
                Transform.translate(
                  offset: const Offset(-400, 0),
                  child: ListView.builder(
                    itemCount: model.subEpisodeList.length,
                    itemBuilder: (_, index) {
                      final subEpisode = model.subEpisodeList[index];
                      return Column(
                        children: [
                          RepaintBoundary(
                            key: subEpisode.iconKey,
                            child: SubEpisodeMarker(index + 1),
                          ),
                          RepaintBoundary(
                            key: subEpisode.invalidIconKey,
                            child: SubEpisodeInvalidMarker(index + 1),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                if (model.currentPosition == null)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        // メインエピソードと自分の位置の中間をカメラ位置に設定してる。
                        target: model.getCameraPosition(),
                        zoom: 15.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        model
                          ..setReExperienceMapController(controller)
                          ..changeMapMode(controller);
                      },
                      markers: {
                        // メインエピソードのマーカー
                        Marker(
                          markerId:
                              MarkerId(model.currentMemory.latLng.toString()),
                          position: model.currentMemory.latLng,
                          icon: model.currentMemory.isSeen
                              ? model.mainEpisodeViewedMarker!
                              : model.mainEpisodeMarker!,
                          anchor: const Offset(0.18, 0.72),
                          onTap: () {
                            // 既に一度目的地に到着していたら、
                            // マーカーをタップしたときにEpisodeViewに遷移するダイアログを表示する
                            if (model.isViewedMainEpisodeDialog) {
                              model.showMainEpisodeDialog();
                            }
                          },
                        ),
                        // サブエピソードのマーカー
                        ...model.subEpisodeList
                            .map((episode) => Marker(
                                  markerId: MarkerId(episode.id.toString()),
                                  position: episode.latLng,
                                  onTap: () {},
                                  icon: (episode.isViewed
                                          ? episode.iconImage
                                          : episode.invalidIconImage) ??
                                      BitmapDescriptor.defaultMarker,
                                  anchor: const Offset(0.445, 0.7),
                                ))
                            .toSet(),
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildBottomSheet(
                      model: model,
                      context: context,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
