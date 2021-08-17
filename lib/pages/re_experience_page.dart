import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/view_models/re_experience_view_model.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
            appBar: AppBar(
              title: const Text("ReExperience"),
            ),
            body: reExperienceViewModel.currentPosition == null
              ? const Center(
              child: CircularProgressIndicator(),
            )
              : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      reExperienceViewModel.currentPosition?.latitude,
                      reExperienceViewModel.currentPosition?.longitude,
                    ),
                    zoom: 15.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    reExperienceViewModel
                      .setReExperienceMapController(controller);
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
                      onTap: () => {
                        showModalBottomSheet(
                          barrierColor: Colors.black.withOpacity(0.0),
                          isDismissible: false,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) =>
                            bottomModalBuilder(
                              context: context,
                              distance: reExperienceViewModel.distance,
                              sigma: reExperienceViewModel.distance / 100,
                            ),
                        )
                      },
                    ),
                  },
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
