import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          homeViewModel.currentPosition!.latitude,
                          homeViewModel.currentPosition!.longitude,
                        ),
                        zoom: 15.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        homeViewModel
                          ..setHomeMapController(controller)
                          ..changeMapMode(controller);
                      },
                      markers: homeViewModel.memories
                          .map(
                            (memory) => Marker(
                              markerId: MarkerId(memory.location.toString()),
                              icon: homeViewModel.memoryMarker!,
                              anchor: const Offset(0.18, 0.72),
                              position: memory.location.toLatLng(),
                              onTap: () {
                                homeViewModel
                                  ..setCurrentMemory(memory)
                                  ..setDistance();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      wid: MediaQuery.of(context).size.width,
                                      descriptions:
                                          "この場所を目的地に\n設定しますか？\n距離は${homeViewModel.distance}mです。",
                                      onSubmitted: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ReExperiencePage(
                                              currentMemory:
                                                  homeViewModel.currentMemory!,
                                            ),
                                          ),
                                        );
                                      },
                                      onCanceled: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          )
                          .toSet(),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FloatingIconButton(
                        icon: Icons.person,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserPage(),
                            ),
                          );
                        },
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
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubEpisodePage(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 32.0,
                ),
                backgroundColor: CustomColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
