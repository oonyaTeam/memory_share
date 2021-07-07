import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/MapModel.dart';
import 'package:memory_share/pages/sub_episode_page.dart';
import 'package:memory_share/widgets/DetermineDestinationDialogBuilder.dart';
import 'package:memory_share/widgets/longButton.dart';
import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   BuildContext _context;
//
//   Completer<GoogleMapController> _controller = Completer();
//
//   Position _currentPosition;
//   StreamSubscription<Position> _positionStream;
//
//   Set<Marker> _markers = <Marker>{};
//   Marker _currentMarker;
//   double _distance = 0.0;
//
//   void _showDetermineDestinationDialog(String markerId) {
//     showDialog(
//       context: _context,
//       builder: (BuildContext context) => DetermineDestinationDialogBuilder(
//         context: context,
//         distance: _distance,
//         onSubmit: () => _disposeController(),
//         marker: _currentMarker,
//       ),
//     );
//   }
//
//   void _onTapMarker(String markerId) {
//     setState(() {
//       _currentMarker =
//           _markers.singleWhere((marker) => marker.markerId.value == markerId);
//       _setDistance();
//     });
//     _showDetermineDestinationDialog(markerId);
//   }
//
//   void _getPosition() async {
//     Position currentPosition = await Geolocator.getCurrentPosition();
//     setState(() {
//       _currentPosition = currentPosition;
//     });
//   }
//
//   void _setDistance() {
//     _distance = Geolocator.distanceBetween(
//       _currentPosition.latitude,
//       _currentPosition.longitude,
//       _currentMarker.position.latitude,
//       _currentMarker.position.longitude,
//     );
//   }
//
//   void _setMarkers() {
//     // Sample Markers
//     List<Marker> markers = [
//       Marker(
//         markerId: MarkerId('marker1'),
//         position: LatLng(34.8532, 136.5822),
//         onTap: () => _onTapMarker('marker1'),
//         infoWindow: InfoWindow(
//           title: 'marker1',
//           snippet: 'text',
//         ),
//       ),
//       Marker(
//         markerId: MarkerId('marker2'),
//         position: LatLng(34.8480, 136.5756),
//         onTap: () => _onTapMarker('marker2'),
//         infoWindow: InfoWindow(
//           title: 'marker2',
//           snippet: 'text',
//         ),
//       ),
//     ];
//     setState(() {
//       _markers.addAll(markers.toSet());
//     });
//   }
//
//   void _disposeController() async {
//     var controller = await _controller.future;
//     controller.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // 現在地を取得
//     _getPosition();
//
//     // マーカーを取得
//     _setMarkers();
//
//     // 現在地の更新を設定
//     _positionStream =
//         Geolocator.getPositionStream().listen((Position position) {
//       setState(() {
//         _currentPosition = position;
//         if (_currentMarker != null) {
//           _setDistance();
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     // 現在地の取得を終了
//     _positionStream?.cancel();
//     _disposeController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _context = context;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: _currentPosition == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Stack(
//               children: [
//                 GoogleMap(
//                   mapType: MapType.normal,
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(
//                       _currentPosition?.latitude,
//                       _currentPosition?.longitude,
//                     ),
//                     zoom: 15.0,
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                   markers: _markers,
//                   myLocationEnabled: true,
//                   zoomControlsEnabled: false,
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 15),
//                     child: longButton(
//                       '思い出を投稿する',
//                       () => {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => SubEpisodePage(),
//                           ),
//                         )
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

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
      appBar: AppBar(
        title: Text(title),
      ),
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
