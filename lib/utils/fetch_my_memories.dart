import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';

/// uuidを投げて自分の投稿を取得する処理です。
Future<List<Memory>> fetchMyMemories(String uuid, String idToken) async {
  // 環境変数にアクセス
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  final url = endpoint + 'mymemories?uuid=' + uuid;

  final resp = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $idToken",
    },
  );

  if (resp.statusCode == 200) {
    final memories = json.decode(resp.body)['memories'];
    if (memories == null) {
      return [];
    } else {
      return List<Memory>.from(
          memories.map((value) => Memory.fromJson(value)).toList());
    }
  } else {
    throw Exception(resp.body);
  }
}
