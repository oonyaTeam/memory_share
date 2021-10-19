import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';

/// 作成したMemoryをAPIへ投稿する。
Future<void> createMemory(
    NewMemory memory, String idToken, http.Client client) async {
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  final resp = await client.post(
    Uri.parse('${endpoint}memories'),
    body: json.encode(memory.toJson()),
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $idToken",
    },
  );

  // ステータスコードが201ならreturnして、そうじゃなかったらエラーを投げる。
  if (resp.statusCode == 201) {
    return;
  } else {
    throw Exception(resp.body.toString());
  }
}
