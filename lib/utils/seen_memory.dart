import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';

/// 思い出を見終わったら誰がどのmemoryを見たのかをサーバに知らせる。
Future<void> seenMemory(
    NewSeenMemory id, String idToken, http.Client client) async {
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  final resp = await client.post(
    Uri.parse(endpoint + 'seen-memory'),
    body: json.encode(id.toJson()),
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