import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

/// 投稿に関する処理をまとめたService
class SeenMemoryService {
  Future<void> updateMemoryId({
    required int id,
  }) async {
    final NewSeenMemory newSeenMemory = NewSeenMemory(id: id);
    final String idToken = await AuthService().getIdToken();
    await seenMemory(newSeenMemory, idToken, http.Client());
  }
}