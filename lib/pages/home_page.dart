import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/pages/user_page.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key key}) : super(key: key);

  void _showDetermineDestinationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => determineDestinationDialogBuilder(
        context: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapModel = context.watch<MapModel>();
    return Scaffold(
      appBar: appBarComponent("Home Page"),
      body: mapModel.currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      mapModel.currentPosition?.latitude,
                      mapModel.currentPosition?.longitude,
                    ),
                    zoom: 15.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapModel.setHomeMapController(controller);
                  },
                  markers: mapModel.memories
                      .map(
                        (memory) => Marker(
                          markerId: MarkerId(memory.latLng.toString()),
                          position: memory.latLng,
                          onTap: () => {
                            mapModel.setCurrentMemory(memory),
                            mapModel.setDistance(),
                            _showDetermineDestinationDialog(context),
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
                      () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SubEpisodePage(),
                          ),
                        )
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
                    color: const Color.fromARGB(255, 233, 103, 75),
                    icon: const Icon(Icons.assignment_ind_rounded),
                  ),
                ),
              ],
            ),
    );
  }
}
