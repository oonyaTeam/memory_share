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

  /// 投稿を取得する処理。現状は、サンプルのデータとAPIから取得したデータを合わせて返している。
  Future<List<Memory>> getMemories() async {
    // サンプルデータ
    List<Memory> sampleMemories = [
      Memory(
        id: 1,
        memory: "this is sample memory1",
        latLng: const LatLng(34.8532, 136.5822),
        episodes: [
          Episode(
            id: 1,
            episode: 'this is sub episode 0',
            latLng: const LatLng(34.8510, 136.588),
          ),
          Episode(
            id: 2,
            episode: 'this is sub episode 1',
            latLng: const LatLng(34.8529, 136.589),
          ),
          Episode(
            id: 3,
            episode: 'this is sub episode 2',
            latLng: const LatLng(34.8520, 136.5801),
          ),
        ],
        image:
            "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
        authorId: 1,
        angle: 30.0,
        isSeen: false,
      ),
      Memory(
        id: 2,
        memory: "this is sample memory2",
        latLng: const LatLng(34.8480, 136.5756),
        episodes: [
          Episode(
            id: 1,
            episode: 'this is sub episode 1',
            latLng: const LatLng(34.8520, 136.580),
          ),
          Episode(
            id: 2,
            episode: 'this is sub episode 2',
            latLng: const LatLng(34.8515, 136.581),
          ),
        ],
        image:
            "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
        authorId: 2,
        angle: 120.0,
        isSeen: true,
      ),
    ];
    sampleMemories = await _memoryService.getMemoryAddresses(sampleMemories);
    List<Memory> memories = await _mapService.getMemories();
    return [...sampleMemories, ...memories];
  }

  ///　現在の位置と目的地との距離を返す
  int getDistance(LatLng startLatLng, LatLng endLatLng) {
    final int distance = _mapService.getDistance(
      startLatLng,
      endLatLng,
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
