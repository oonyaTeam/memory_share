import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:memory_share/pages/post_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuildContext _context;

  Completer<GoogleMapController> _controller = Completer();
  Location _locationService = Location();
  StreamSubscription _locationChangedListen;

  LocationData _currentLocation;
  Set<Marker> _markers = <Marker>{};

  void _showBottomModal(String markerId) {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.0),
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: _context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("あと○○m"),
              Container(
                child: Image.asset(
                  'assets/sample_image.jpg',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDetermineDestinationDialog(String markerId) {
    showDialog(
      context: _context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("この場所を目的地に設定しますか？"),
        content: Text("目的地までの距離は、○○mです。"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(_context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(_context);
              _showBottomModal(markerId);
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  void _onTapMarker(String markerId) {
    _showDetermineDestinationDialog(markerId);
  }

  void _getLocation() async {
    _currentLocation = await _locationService.getLocation();
  }

  void _setMarkers() {
    // Sample Markers
    List<Marker> markers = [
      Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(34.8532, 136.5822),
        onTap: () => _onTapMarker('marker1'),
        infoWindow: InfoWindow(
          title: 'marker1',
          snippet: 'text',
        ),
      ),
      Marker(
        markerId: MarkerId('marker2'),
        position: LatLng(34.8480, 136.5756),
        onTap: () => _onTapMarker('marker2'),
        infoWindow: InfoWindow(
          title: 'marker2',
          snippet: 'text',
        ),
      ),
    ];
    setState(() {
      _markers.addAll(markers.toSet());
    });
  }

  @override
  void initState() {
    super.initState();

    // 現在地を取得
    _getLocation();

    // マーカーを取得
    _setMarkers();

    // 現在地の更新を設定
    _locationChangedListen =
        _locationService.onLocationChanged.listen((LocationData result) async {
      setState(() {
        _currentLocation = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 現在地の取得を終了
    _locationChangedListen?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _currentLocation == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentLocation.latitude, _currentLocation.longitude),
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
              myLocationEnabled: true,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PostPage(),
            ),
          )
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
