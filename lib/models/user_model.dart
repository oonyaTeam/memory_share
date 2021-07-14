import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

class UserModel with ChangeNotifier {
  UserModel() {
    getMyMemories();
  }

  File _photo;
  final List<String> _subEpisodeList = [];
  List<Memory> _myMemories = [];

  File get photo => _photo;

  List<String> get subEpisodeList => _subEpisodeList;

  List<Memory> get myMemories => _myMemories;

  void setPhoto(File photo) {
    _photo = photo;
    notifyListeners();
  }

  void addSubEpisode(String subEpisode) {
    _subEpisodeList.add(subEpisode);
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
    const uuid = "author1"; // this is sample
    await fetchMyMemories(uuid)
        .then((myMemories) => _myMemories = myMemories);
    notifyListeners();
  }
}
