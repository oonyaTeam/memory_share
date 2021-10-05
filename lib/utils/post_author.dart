import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

Future<void> postAuthorRequest(String idToken) async {
  final endpoint = FlutterConfig.get("API_ENDPOINT");
  final uri = endpoint + 'author';

  final resp = await http.post(
    Uri.parse(uri),
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $idToken",
    },
  );

  if (resp.statusCode == 201) {
    return;
  } else {
    throw Exception(resp.body);
  }
}
