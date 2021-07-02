import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/pages/sub_episode_page.dart';
import 'package:memory_share/widgets/longButton.dart';

class ReExperiencePage extends StatefulWidget {

  ReExperiencePage({Key key, this.marker}) : super(key: key);

  final Marker marker;

  @override
  _ReExperiencePageState createState() => _ReExperiencePageState();
}

class _ReExperiencePageState extends State<ReExperiencePage> {

  BuildContext _context;

  Completer<GoogleMapController> _controller = Completer();

  Position _currentPosition;
  StreamSubscription<Position> _positionStream;

  Marker _currentMarker;
  double _distance = 0.0;

  void _getPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = currentPosition;
    });
  }

  void _setMarker() {
    _currentMarker = widget.marker;
  }

  void _showBottomModal() {
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
              Text("あと${_distance}m"),
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

  @override
  void initState() {
    super.initState();

    // 現在地を取得
    _getPosition();

    // マーカーを取得
    _setMarker();

    // 現在地の更新を設定
    _positionStream =
      Geolocator.getPositionStream().listen((Position position) {
        setState(() {
          _currentPosition = position;
          if (_currentMarker != null) {
            _distance = Geolocator.distanceBetween(
              _currentPosition.latitude,
              _currentPosition.longitude,
              _currentMarker.position.latitude,
              _currentMarker.position.longitude,
            );
          }
        });
      });

    _showBottomModal();
  }

  @override
  void dispose() {
    super.dispose();
    // 現在地の取得を終了
    _positionStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("ReExperience"),
      ),
      body: _currentPosition == null
        ? Center(
        child: CircularProgressIndicator(),
      )
        : Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                _currentPosition?.latitude,
                _currentPosition?.longitude,
              ),
              zoom: 15.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              _currentMarker
            },
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
