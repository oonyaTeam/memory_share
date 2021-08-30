import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

void main() {
  Memory memory;

  setUp(() {
    memory = Memory(
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

  group("createMemory", () {
    test("test", () async {
      // await createMemory(memory);
      expect("test", "test");
    });
  });
}
