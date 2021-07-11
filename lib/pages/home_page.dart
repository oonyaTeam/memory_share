import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:memory_share/pages/user_page.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  void _showDetermineDestinationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => DetermineDestinationDialogBuilder(
        context: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapModel = context.watch<MapModel>();
    return Scaffold(
      appBar: AppBarComponent(title),
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
            markers: mapModel.markers
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
          Align(
              alignment: Alignment.topLeft,
              child:IconButton(
                iconSize: 64,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
                  },
                color: const Color.fromARGB(255, 233, 103, 75),
                icon: const Icon(Icons.assignment_ind_rounded),
              )
          ),
        ],
      ),
    );
  }
}