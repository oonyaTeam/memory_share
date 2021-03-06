import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
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
  // Memory sampleMemory = Memory(
  //   id: 1,
  //   memory: "this is sample memory1",
  //   location: const LatLng(34.8532, 136.5822),
  //   episodes: [
  //     Episode(
  //       id: 1,
  //       episode: 'this is sub episode 0',
  //       location: const Location(latitude: 34.8510, longitude: 136.588),
  //     ),
  //     Episode(
  //       id: 2,
  //       episode: 'this is sub episode 1',
  //       location: const Location(latitude: 34.8529, longitude: 136.589),
  //     ),
  //     Episode(
  //       id: 3,
  //       episode: 'this is sub episode 2',
  //       location: const Location(latitude: 34.8520, longitude: 136.5801),
  //     ),
  //   ],
  //   image: "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
  //   authorId: 1,
  //   angle: 30.0,
  //   isSeen: false,
  // );

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

      // final List<Memory> memories = await fetchMemories(lowerLeft: lowerLeft, lowerRight: lowerRight, upperLeft: upperLeft, upperRight: upperRight, idToken: idToken, client: client);

      // expect(memories[0].toJson(), sampleMemory.toJson());
    });

    test("Throw Exception on Server Error", () {
      final client = MockClient();

      final uri =
          '${apiEndpoint}memories?lowerLeft=$lowerLeft&lowerRight=$lowerRight&upperLeft=$upperLeft&upperRight=$upperRight';

      when(client.get(Uri.parse(uri))).thenAnswer((_) async =>
          http.Response('{ "msg" : "query pram does not exist" }', 400));

      // expect(
      //   () async => await fetchMemories(
      //       lowerLeft, lowerRight, upperLeft, upperRight, client),
      //   throwsException,
      // );
    });
  });
}
