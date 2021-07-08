import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/MapModel.dart';
import 'package:memory_share/pages/sub_episode_page.dart';
import 'package:memory_share/widgets/DetermineDestinationDialogBuilder.dart';
import 'package:memory_share/widgets/longButton.dart';
import 'package:memory_share/widgets/AppBar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage({this.title});

  void _showDetermineDestinationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => DetermineDestinationDialogBuilder(
        context: context,
      ),
    );
  }

  List<MarkerData> getMarkers() {
    List<MarkerData> markers = [
      MarkerData('marker1', LatLng(34.8532, 136.5822)),
      MarkerData('marker2', LatLng(34.8480, 136.5756)),
    ];
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final mapModel = context.watch<MapModel>();
    return Scaffold(
      appBar: AppBarComponent(title),
      body: mapModel.currentPosition == null
        ? Center(
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
              mapModel.setMapController(controller);
            },
            markers: getMarkers()
              .map(
                (data) => Marker(
                markerId: MarkerId(data.markerId),
                position: data.position,
                onTap: () => {
                  mapModel.setCurrentMarker(data),
                  mapModel.setDistance(),
                  _showDetermineDestinationDialog(context),
                },
                infoWindow: InfoWindow(
                  title: data.markerId,
                  snippet: 'text',
                ),
              ),
            ).toSet(),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 15),
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
        ],
      ),
    );
  }
}
