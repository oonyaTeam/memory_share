
import 'dart:io';

import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {

  File _photo;
  List<String> _subEpisodeList = [];

  File get photo => _photo;
  List<String> get subEpisodeList => _subEpisodeList;

  void setPhoto(File photo) {
    _photo = photo;
  }

  void addSubEpisode(String subEpisode) {
    _subEpisodeList.add(subEpisode);
    notifyListeners();
  }

  void removeSubEpisode(int index) {
    _subEpisodeList.removeAt(index);
    notifyListeners();
  }

}