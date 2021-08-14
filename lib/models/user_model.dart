import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

class UserModel with ChangeNotifier {
  UserModel() {
    getMyMemories();
  }

  File _photo;
  List<Memory> _myMemories = [];
  final List<SubEpisode> _subEpisodeList = [];
  String _mainEpisode;

  File get photo => _photo;

  List<Memory> get myMemories => _myMemories;

  List<SubEpisode> get subEpisodeList => _subEpisodeList;

  String get mainEpisode => _mainEpisode;

  void setPhoto(File photo) {
    _photo = photo;
    notifyListeners();
  }

  void addSubEpisode(String subEpisode) async {
    final position = await Geolocator.getCurrentPosition();
    _subEpisodeList.add(SubEpisode(
      latLng: LatLng(position.latitude, position.longitude),
      episode: subEpisode,
    ));
    notifyListeners();
  }

  void removeSubEpisode(int index) {
    _subEpisodeList.removeAt(index);
    notifyListeners();
  }

  void clearSubEpisode() {
    _subEpisodeList.clear();
    notifyListeners();
  }

  void getMyMemories() async {
    const uuid = "author1"; // TODO: sampleなので、firebase Authを導入したら変える
    await fetchMyMemories(uuid).then((myMemories) => _myMemories = myMemories);
    notifyListeners();
  }

  Future<void> postMemory(String memory) async {
    final currentPosition = await Geolocator.getCurrentPosition();

    // TODO: 自分をauthorとseenAuthorに登録してる。sampleなので（以下略
    // TODO: サンプルimageをセット（cloud storageに上げて、Urlを入れる処理が必要）
    // episode: idにindexを入れたいので、一度Mapにして、展開している。idに入れる値は後々検討すべき？
    final _newMemory = Memory(
      memory: memory,
      author: "author1",
      seenAuthor: ["author1"],
      image:
          "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
      latLng: LatLng(currentPosition.latitude, currentPosition.longitude),
      episodes: List<Episode>.from(
          _subEpisodeList.asMap().entries.map((subEpisode) => Episode(
                id: subEpisode.key.toString(),
                episode: subEpisode.value.episode,
                distance: Geolocator.distanceBetween(
                  currentPosition.latitude,
                  currentPosition.longitude,
                  subEpisode.value.latLng.latitude,
                  subEpisode.value.latLng.longitude,
                ).toInt(),
              ))),
    );
    await createMemory(_newMemory);
  }
}
