import 'package:flutter/material.dart';

class AddSubEpisodeViewModel with ChangeNotifier {
  AddSubEpisodeViewModel();

  /// テキストフォームのCotroller
  final TextEditingController textEditingController = TextEditingController();

  /// テキストフォームのフォーカス（キーボードの表示・非表示）を扱うもの
  final textFieldFocusNode = FocusNode();

  /// 追加するサブエピソード
  String _subEpisode = '';

  String get subEpisode => _subEpisode;

  set subEpisode(String str) {
    _subEpisode = str;
    notifyListeners();
  }

  /// テキストフォームにフォーカス（キーボードを表示）する。
  void unfocusTextField() => textFieldFocusNode.unfocus();

  /// テキストフォームからフォーカスを外す（キーボードを閉じる）。
  void focusTextField() => textFieldFocusNode.requestFocus();
}
