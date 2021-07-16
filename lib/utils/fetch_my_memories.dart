import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';

Future<List<Memory>> fetchMyMemories(String uuid) async {
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  final url = endpoint + 'mymemories?uuid=' + uuid;
  final resp = await http.get(Uri.parse(url));

  if (resp.statusCode == 200) {
    return List<Memory>.from(json
      .decode(resp.body)['memories']
      .map((value) => Memory.fromJson(value))
      .toList());
  } else {
    throw Exception('An error has occurred!');
  }
}
