import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/widgets/sub_episode_marker.dart';
import 'package:provider/provider.dart';

import 're_experience_view_model.dart';

class ReExperiencePage extends StatelessWidget {
  const ReExperiencePage({
    Key? key,
    required this.currentMemory,
  }) : super(key: key);

  final Memory currentMemory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReExperienceViewModel(currentMemory, context),
      child: Consumer<ReExperienceViewModel>(
        builder: (context, reExperienceViewModel, _) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            reExperienceViewModel.getMarkerBitmaps();
          });
          return Scaffold(
            body: Stack(
              children: [
                /// 画面の外で、サブエピソードを描画している。
                Transform.translate(
                  offset: const Offset(-200, -200),
                  child: ListView.builder(
                    itemCount: reExperienceViewModel.subEpisodeList.length,
                    itemBuilder: (_, index) {
                      final subEpisode =
                          reExperienceViewModel.subEpisodeList[index];
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
                reExperienceViewModel.currentPosition == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                // メインエピソードと自分の位置の中間をカメラ位置に設定してる。
                                target:
                                    reExperienceViewModel.getCameraPosition(),
                                zoom: 15.0,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                reExperienceViewModel
                                  ..setReExperienceMapController(controller)
                                  ..changeMapMode(controller);
                              },
                              markers: {
                                // メインエピソードのマーカー
                                Marker(
                                  markerId: MarkerId(reExperienceViewModel
                                      .currentMemory.latLng
                                      .toString()),
                                  position: reExperienceViewModel
                                      .currentMemory.latLng,
                                  infoWindow: const InfoWindow(
                                    title: "目的地",
                                  ),
                                  icon:
                                      reExperienceViewModel.mainEpisodeMarker!,
                                  onTap: () {
                                    // 既に一度目的地に到着していたら、
                                    // マーカーをタップしたときにEpisodeViewに遷移するダイアログを表示する
                                    if (reExperienceViewModel
                                        .isViewedMainEpisodeDialog) {
                                      reExperienceViewModel
                                          .showMainEpisodeDialog();
                                    }
                                  },
                                ),
                                // サブエピソードのマーカー
                                ...reExperienceViewModel.subEpisodeList
                                    .map((episode) => Marker(
                                          markerId:
                                              MarkerId(episode.id.toString()),
                                          position: episode.latLng,
                                          onTap: () {},
                                          infoWindow: InfoWindow(
                                            title: episode.episode,
                                            snippet:
                                                episode.distance.toString(),
                                          ),
                                          icon: episode.isViewed
                                              ? episode.iconImage!
                                              : episode.invalidIconImage!,
                                        ))
                                    .toSet(),
                              },
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                            ),
                          ),
                          Container(
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
                                  margin: const EdgeInsets.only(
                                      top: 16, bottom: 16),
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
                                          text:
                                              "${reExperienceViewModel.distance}",
                                          style:
                                              const TextStyle(fontSize: 24.0),
                                        ),
                                        const TextSpan(text: "m"),
                                      ],
                                    ),
                                  ),
                                ),
                                // TODO: デバック用にいつでもEpisodeViewPageに遷移できるようにしてあるが、リリース時には削除する。
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EpisodeViewPage(
                                          reExperienceViewModel.currentMemory,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: ImageFiltered(
                                      child: Image.network(reExperienceViewModel
                                          .currentMemory.image),
                                      imageFilter: ImageFilter.blur(
                                        sigmaX:
                                            reExperienceViewModel.sigma / 10,
                                        sigmaY:
                                            reExperienceViewModel.sigma / 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
