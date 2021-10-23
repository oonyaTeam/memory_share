import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AskPermissionViewModel with ChangeNotifier {
  void openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
