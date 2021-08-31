import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_memory_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  Memory sampleMemory;

  const apiEndpoint = 'http://example.com/'; // サンプルエンドポイント
  FlutterConfig.loadValueForTesting({'API_ENDPOINT': apiEndpoint});

  setUp(() {
    sampleMemory = Memory(
      memory: "this is sample main episode",
      latLng: const LatLng(34.8532, 136.5822),
      seenAuthor: ["author1"],
      episodes: [
        Episode(
          id: "episodeId1",
          episode: "This is sample sub episode",
          latLng: const LatLng(34.8528, 136.5817),
        ),
      ],
      image:
          "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
      author: "author1",
    );
  });

  group("createMemory testing", () {
    test("create sample Memory", () async {
      final client = MockClient();

      when(client.post(
        Uri.parse(apiEndpoint + 'create-memory'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{ "msg": "OK" }', 201));

      await createMemory(sampleMemory, client);

      verify(client.post(
        Uri.parse(apiEndpoint + 'create-memory'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ));
    });
  });
}
