import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_memories_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const apiEndpoint = 'http://example.com/'; // モックAPIのエンドポイント
  FlutterConfig.loadValueForTesting({'API_ENDPOINT': apiEndpoint});

  num lowerLeft = 10;
  num lowerRight = 10;
  num upperLeft = 50;
  num upperRight = 50;
  Memory sampleMemory = Memory(
    memory:
        "main episode1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
    latLng: const LatLng(40.5, 30.5),
    seenAuthor: ["author1", "author2"],
    episodes: [
      Episode(
        id: "first_id",
        episode:
            "subepisode 1Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        latLng: const LatLng(40.5, 30.5),
      ),
      Episode(
        id: "second_id",
        episode:
            "sub episode2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        latLng: const LatLng(40.5, 30.5),
      ),
    ],
    image: "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
    author: "author1",
  );

  setUp(() {});

  group("Fetch Memories testing", () {
    test("Fetch Memories(check", () async {
      final client = MockClient();

      final uri =
          '${apiEndpoint}memories?lowerLeft=$lowerLeft&lowerRight=$lowerRight&upperLeft=$upperLeft&upperRight=$upperRight';

      when(client.get(Uri.parse(uri))).thenAnswer((_) async => http.Response("""
{
		"memories":[
				{
						"memory": "main episode1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
						"longitude": 30.5,
						"latitude": 40.5,
						"seen_author":[
								"author1",
								"author2"
						],
						"episodes":[
								{
									"id": "first_id",
									"episode": "subepisode 1Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
									"longitude": 30.5,
									"latitude": 40.5
								},
								{
									"id": "second_id",
									"episode": "sub episode2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
									"longitude": 30.5,
									"latitude": 40.5
								}
						],
						"image": "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
						"author": "author1"
				}
		]
}""", 200));

      final List<Memory> memories = await fetchMemories(
          lowerLeft, lowerRight, upperLeft, upperRight, client);

      expect(memories[0].toJson(), sampleMemory.toJson());
    });

    test("Throw Exception on Server Error", () {
      final client = MockClient();

      final uri =
          '${apiEndpoint}memories?lowerLeft=$lowerLeft&lowerRight=$lowerRight&upperLeft=$upperLeft&upperRight=$upperRight';

      when(client.get(Uri.parse(uri))).thenAnswer((_) async =>
          http.Response('{ "msg" : "query pram does not exist" }', 400));

      expect(
        () async => await fetchMemories(
            lowerLeft, lowerRight, upperLeft, upperRight, client),
        throwsException,
      );
    });
  });
}
