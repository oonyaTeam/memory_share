import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

void main() {
  const apiEndpoint = 'http://127.0.0.1:8081/'; // モックAPIのエンドポイント
  FlutterConfig.loadValueForTesting({'API_ENDPOINT': apiEndpoint});

  setUp(() {});

  group("Fetch Memories test", () {
    test("test", () async {
      final List<Memory> memories = await fetchMemories();
      expect(memories.toString(), memories.toString());
    });
  });
}

// final memory = Memory(
//   memory:
//       "main episode1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
//   latLng: const LatLng(40.5, 30.5),
//   seenAuthor: ["author1", "author2"],
//   episodes: [
//     Episode(
//       id: "first_id",
//       episode:
//           "subepisode 1Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
//       latLng: const LatLng(40.5, 30.5),
//     ),
//     Episode(
//       id: "second_id",
//       episode:
//           "subepisode 1Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
//       latLng: const LatLng(40.5, 30.5),
//     ),
//   ],
//   image: "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
//   author: "author1",
// );
