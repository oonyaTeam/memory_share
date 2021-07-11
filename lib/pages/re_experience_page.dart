import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ReExperiencePage extends StatelessWidget {

  const ReExperiencePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapModel = context.watch<MapModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("ReExperience"),
      ),
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
                    mapModel.setReExperienceMapController(controller);
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId(mapModel.currentMarker.markerId),
                      position: mapModel.currentMarker.position,
                      infoWindow: InfoWindow(
                        title: mapModel.currentMarker.markerId,
                        snippet: 'text',
                      ),
                      onTap: () => {
                        showModalBottomSheet(
                          barrierColor: Colors.black.withOpacity(0.0),
                          isDismissible: false,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) => BottomModalBuilder(
                            context: context,
                            distance: mapModel.distance,
                            sigma: mapModel.sigma,
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
}
