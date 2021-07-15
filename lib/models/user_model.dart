import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

class SubEpisode {
  LatLng latLng;
  String episode;

  SubEpisode({this.latLng, this.episode});
}

class UserModel with ChangeNotifier {
  UserModel() {
    getMyMemories();
  }

  File _photo;
  List<Memory> _myMemories = [];
  final List<SubEpisode> _subEpisodeList = [];
  String _mainEpisode;
  Memory _newMemory;

  File get photo => _photo;

  List<Memory> get myMemories => _myMemories;

  List<SubEpisode> get subEpisodeList => _subEpisodeList;

  String get mainEpisode => _mainEpisode;

  Memory get newMemory => _newMemory;

  void setPhoto(File photo) {
    _photo = photo;
    notifyListeners();
  }

  void setMemory(String memory) {
    _newMemory.memory = memory;
    notifyListeners();
    // post_pageで再レンダリングしないためにここではnotifyListeners()を呼び出さない。
    // 投稿内容を永続化しておくなら、ここにその処理を記述する。
  }

  void addSubEpisode(String subEpisode) async {
    final position = await Geolocator.getCurrentPosition();
    _subEpisodeList.add(SubEpisode(
      latLng: LatLng(position.latitude, position.longitude),
      episode: subEpisode,
    ));
    // _newMemory.episodes.add(Episode(episode: subEpisode, id: 'sample', distance: 30));
    notifyListeners();
  }

  void removeSubEpisode(int index) {
    _subEpisodeList.removeAt(index);
    // _newMemory.episodes.removeAt(index);
    notifyListeners();
  }

  void clearSubEpisode() {
    _subEpisodeList.clear();
    _newMemory.episodes.clear();
    notifyListeners();
  }

  void getMyMemories() async {
    const uuid = "author1"; // TODO: sampleなので、firebase Authを導入したら変える
    await fetchMyMemories(uuid).then((myMemories) => _myMemories = myMemories);
    notifyListeners();
  }

  Future<void> postMemory(String memory) async {
    // TODO: 自分をauthorとseenAuthorに登録してる。sampleなので（以下略

    _newMemory.author = "author1";
    _newMemory.seenAuthor = ["author1"];

    // TODO: サンプルimageをセット（cloud storageに上げて、Urlを入れる処理が必要）
    _newMemory.image =
        "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large";

    final currentPosition = await Geolocator.getCurrentPosition();

    _newMemory.latLng = LatLng(currentPosition.latitude, currentPosition.longitude);

    // idにindexを入れたいので、一度Mapにして、展開している。idに入れる値は後々検討すべき？
    _newMemory.episodes =
        _subEpisodeList.asMap().entries.map((subEpisode) => Episode(
              id: subEpisode.key.toString(),
              episode: subEpisode.value.episode,
              distance: Geolocator.distanceBetween(
                currentPosition.latitude,
                currentPosition.longitude,
                subEpisode.value.latLng.latitude,
                subEpisode.value.latLng.longitude,
              ),
            ));
    await createMemory(_newMemory);
  }
}
