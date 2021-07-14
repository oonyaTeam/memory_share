import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

class UserModel with ChangeNotifier {
  UserModel() {
    getMyMemories();
  }

  File _photo;
  List<Memory> _myMemories = [];
  final List<String> _subEpisodeList = [];
  Memory _newMemory;

  File get photo => _photo;
  List<Memory> get myMemories => _myMemories;
  List<String> get subEpisodeList => _subEpisodeList;
  Memory get newMemory => _newMemory;

  void setPhoto(File photo) {
    _photo = photo;
    notifyListeners();
  }

  void addSubEpisode(String subEpisode) {
    _subEpisodeList.add(subEpisode);
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

  void postMemory() async {
    // TODO: サンプルimageをセット（cloud storageに上げて、Urlを入れる処理が必要）
    _newMemory.image =
        "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large";
    await createMemory(_newMemory);
  }
}
