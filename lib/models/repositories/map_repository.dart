import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

/// マップ（閲覧）に関する処理をまとめたリポジトリ
class MapRepository {
  final MapService _mapService = MapService();
  final MemoryService _memoryService = MemoryService();

  /// 投稿を取得する処理
  ///
  /// APIから投稿一覧を取得し、位置情報から住所を取得して返す。
  Future<List<Memory>> getMemories() async {
    List<Memory> memories = await _mapService.getMemories();
    return await _memoryService.getMemoryAddresses(memories);
  }

  ///　現在の位置と目的地との距離を返す
  int getDistance(Location start, Location end) {
    final int distance = _mapService.getDistance(
      start,
      end,
    );
    return distance;
  }

  Future<BitmapDescriptor> getMainEpisodeMarkerBitmap() async {
    return BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/memory_spot_icon.png',
    );
  }

  Future<BitmapDescriptor> getSubEpisodeMarkerBitmap(GlobalKey iconKey) async {
    Future<Uint8List> _capturePng(GlobalKey iconKey) async {
      if (iconKey.currentContext == null) {
        await Future.delayed(const Duration(milliseconds: 20));
        return _capturePng(iconKey);
      }
      RenderRepaintBoundary boundary =
          iconKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return _capturePng(iconKey);
      }
      ui.Image image = await boundary.toImage(pixelRatio: 2.5);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    }

    Uint8List imageData = await _capturePng(iconKey);
    return BitmapDescriptor.fromBytes(imageData);
  }
}
