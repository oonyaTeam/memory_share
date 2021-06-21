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
  Completer<GoogleMapController> _controller = Completer();

  Location _locationService = Location();
  LocationData _currentLocation;
  StreamSubscription _locationChangedListen;

  Set<Marker> _markers = <Marker>{};

  void _getLocation() async {
    _currentLocation = await _locationService.getLocation();
  }

  void _onTapMarker(String markerId) {}

  void _setMarkers() {
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
        onTap: () => {},
      ),
    ];
    setState(() {
      _markers.addAll(markers.toSet());
    });
  }

  @override
  void initState() {
    super.initState();

    _getLocation();

    _setMarkers();

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
    _locationChangedListen?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _currentLocation == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
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
                AnimatedPositioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      height: 70.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 20,
                            offset: Offset.zero,
                            color: Colors.grey.withOpacity(0.5)
                          )]
                      ),
                      child: Text('test'),
                    ),
                  ),
                  duration: Duration(
                    milliseconds: 200,
                  ),
                ),
              ],
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
