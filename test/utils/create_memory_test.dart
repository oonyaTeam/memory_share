import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:mock_web_server/mock_web_server.dart';

void main() {
  Memory sampleMemory;

  const apiEndpoint = 'http://127.0.0.1:8081/'; // モックAPIのエンドポイント
  FlutterConfig.loadValueForTesting({'API_ENDPOINT': apiEndpoint});

  final _server = MockWebServer(port: 8081);

  setUp(() {
    _server.start(); // Mockサーバーを起動

    sampleMemory = Memory(
      memory: "this is sample main episode",
      latLng: const LatLng(34.8532, 136.5822),
      seenAuthor: ["author1"],
      episodes: [
        Episode(
          id: "episodeId1",
          episode: "This is sample sub episode",
          distance: 200,
        ),
      ],
      image:
          "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
      author: "author1",
    );
  });

  // 全てのテストが終了したら、Mockサーバーを閉じる。
  tearDown(_server.shutdown);

  group("createMemory testing", () {
    test("test", () async {
      _server.enqueue(httpCode: 201, body: '{ "msg: "OK" }');
      await createMemory(sampleMemory);
      expect("test", "test");
    });
  });
}
