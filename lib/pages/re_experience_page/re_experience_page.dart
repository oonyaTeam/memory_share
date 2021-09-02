import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:provider/provider.dart';

import 're_experience_view_model.dart';

class ReExperiencePage extends StatelessWidget {
  const ReExperiencePage({Key key, @required this.currentMemory})
      : super(key: key);

  final Memory currentMemory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReExperienceViewModel(),
      child: Consumer<ReExperienceViewModel>(
          builder: (context, reExperienceViewModel, _) {
        reExperienceViewModel.setCurrentMemory(currentMemory);
        return Scaffold(
          body: reExperienceViewModel.currentPosition == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        // メインエピソードと自分の位置の中間をカメラ位置に設定してる。
                        target: reExperienceViewModel.getCameraPosition(),
                        zoom: 15.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        reExperienceViewModel
                            .setReExperienceMapController(controller);
                        reExperienceViewModel.changeMapMode(controller);
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId(reExperienceViewModel
                              .currentMemory.latLng
                              .toString()),
                          position: reExperienceViewModel.currentMemory.latLng,
                          infoWindow: const InfoWindow(
                            title: "目的地",
                            snippet: 'text',
                          ),
                          onTap: () {},
                        ),
                        ...reExperienceViewModel.currentMemory.episodes
                            .map((episode) => Marker(
                                  markerId: MarkerId(episode.id),
                                  position: episode.latLng,
                                  onTap: () {},
                                ))
                            .toSet(),
                      },
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
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
                              margin:
                                  const EdgeInsets.only(top: 16, bottom: 16),
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
                                      text: "${reExperienceViewModel.distance}",
                                      style: const TextStyle(fontSize: 24.0),
                                    ),
                                    const TextSpan(text: "m"),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EpisodeViewPage(),
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
                                        reExperienceViewModel.distance / 100,
                                    sigmaY:
                                        reExperienceViewModel.distance / 100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
