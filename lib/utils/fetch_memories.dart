import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';

/// APIから投稿を取得する。緯度経度それぞれの上限、下限を指定することで、その範囲の投稿を取得できる。
Future<List<Memory>> fetchMemories(
    {num lowerLeft, num lowerRight, num upperLeft, num upperRight}) async {
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  final url =
      '${endpoint}memories?lowerLeft=$lowerLeft&lowerRight=$lowerRight&upperLeft=$upperLeft&upperRight=$upperRight';
  final resp = await http.get(Uri.parse(url));

  // ステータスコードが200なら、取得したデータを[Memory]に変換して返す。
  // それ以外はエラーを投げる。
  if (resp.statusCode == 200) {
    // 受け取ったJson内の'memories'のリストの各要素に対して、Json -> Memoryの変換を行い、Memoryのリストにして返す。
    return List<Memory>.from(json
        .decode(resp.body)['memories']
        .map((value) => Memory.fromJson(value))
        .toList());
  } else {
    throw Exception('An error has occurred!');
  }
}
