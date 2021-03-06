import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_memory_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  // final NewMemory sampleMemory = NewMemory(
  //   memory: "this is sample main episode",
  //   location: const Location(
  //     latitude: 34.8532,
  //     longitude: 136.5822,
  //   ),
  //   episodes: [
  //     Episode(
  //       id: 0,
  //       episode: "This is sample sub episode",
  //       location: const Location(
  //         latitude: 34.8528,
  //         longitude: 136.5817,
  //       ),
  //     ),
  //   ],
  //   image: "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
  //   angle: 30,
  // );

  const apiEndpoint = 'http://example.com/'; // サンプルエンドポイント
  FlutterConfig.loadValueForTesting({'API_ENDPOINT': apiEndpoint});

  setUp(() {});

  group("createMemory testing", () {
    test("create sample Memory", () async {
      final client = MockClient();

      when(client.post(
        Uri.parse(apiEndpoint + 'create-memory'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{ "msg": "OK" }', 201));

      // await createMemory(sampleMemory, client);

      verify(client.post(
        Uri.parse(apiEndpoint + 'create-memory'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ));
    });

    test("Throw Exception", () async {
      final client = MockClient();

      when(client.post(
        Uri.parse(apiEndpoint + 'create-memory'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{ "msg": "Error" }', 400));

      // expect(() async => await createMemory(sampleMemory, client),
      //     throwsException);
    });
  });
}
