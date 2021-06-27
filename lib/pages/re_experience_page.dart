import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart' show rootBundle;

class ReExperiencePage extends StatelessWidget {
  ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImagesMap = Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ReExperiencePage"),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        type: ArCoreViewType.AUGMENTEDIMAGES,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async{
    arCoreController = controller;
    //arCoreController.onTrackingImage = _handleOnTrackingImage;
    //loadImagesDatabase();
  }

  loadImagesDatabase() async {
    final ByteData bytes = await rootBundle.load('INSERT IMAGE DATABASE URL');
    arCoreController.loadAugmentedImagesDatabase(
        bytes: bytes.buffer.asUint8List());
  }

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.index)) {
      augmentedImagesMap[augmentedImage.index] = augmentedImage;

      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage()));
    }
  }
}