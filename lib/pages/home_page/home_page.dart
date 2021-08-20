import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) => Scaffold(
          appBar: appBarComponent("Home Page"),
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
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: longButton(
                          '思い出を投稿する',
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SubEpisodePage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        iconSize: 64,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserPage(),
                            ),
                          );
                        },
                        color: newTheme().primary,
                        icon: const Icon(Icons.circle),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        iconSize: 64,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserPage(),
                            ),
                          );
                        },
                        color: const Color.fromARGB(255, 255, 255, 255),
                        icon: const Icon(Icons.account_circle_rounded),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
