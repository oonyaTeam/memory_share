import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';

Future<void> createMemory(Memory memory) async {
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  final resp = await http.post(
    Uri.parse(endpoint + 'create-memory'),
    body: json.encode(memory.toJson()),
    headers: {'Content-Type': 'application/json'},
  );

  if (resp.statusCode == 201) {
    return;
  } else {
    throw Exception(resp.body.toString());
  }
}
