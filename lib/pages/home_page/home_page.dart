import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  void _showDetermineDestinationDialog({
    @required BuildContext context,
    @required HomeViewModel model,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => determineDestinationDialogBuilder(
        context: context,
        model: model,
      ),
    );
  }

  void _showTutorial(BuildContext context) {
    if (context.read<UserModel>().reExperienceTutorialDone) return;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ReExperienceTutorialPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial(context));

    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) => Scaffold(
          body: homeViewModel.currentPosition == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          homeViewModel.currentPosition?.latitude,
                          homeViewModel.currentPosition?.longitude,
                        ),
                        zoom: 15.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        homeViewModel.setHomeMapController(controller);
                        homeViewModel.changeMapMode(controller);
                      },
                      markers: homeViewModel.memories
                          .map(
                            (memory) => Marker(
                              markerId: MarkerId(memory.latLng.toString()),
                              position: memory.latLng,
                              onTap: () async {
                                homeViewModel.setCurrentMemory(memory);
                                await homeViewModel.setDistance();
                                _showDetermineDestinationDialog(
                                  context: context,
                                  model: homeViewModel,
                                );
                              },
                              infoWindow: InfoWindow(
                                title: memory.latLng.toString(),
                                snippet: 'text',
                              ),
                            ),
                          )
                          .toSet(),
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16.0, right: 16.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 20,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: IconButton(
                          iconSize: 32.0,
                          padding: const EdgeInsets.all(16),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserPage(),
                              ),
                            );
                          },
                          color: newTheme().primary,
                          icon: const Icon(Icons.person),
                        ),
                      ),
                    ),
                  ],
                ),
          floatingActionButton: SizedBox(
            width: 64.0,
            height: 64.0,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 20,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubEpisodePage(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 32.0,
                ),
                backgroundColor: newTheme().primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
