import 'dart:convert';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';

Future<List<Memory>> fetchMemories(num lowerLeft, num lowerRight, num upperLeft, num upperRight) async {
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  final url = '${endpoint}memories?lowerLeft=$lowerLeft&lowerRight=$lowerRight&upperLeft=$upperLeft&upperRight=$upperRight';
  final resp = await http.get(Uri.parse(url));

  if (resp.statusCode == 200) {
    return json
      .decode(resp.body)['memories']
      .map((value) => Memory.fromJson(value))
      .toList();
  } else {
    throw Exception('An error has occurred!');
  }
}