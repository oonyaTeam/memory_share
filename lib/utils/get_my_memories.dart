import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

void getMemories () {
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  http.get(endpoint);
}