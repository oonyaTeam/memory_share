import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

class MemoryService {
  /// ユーザの投稿を取得
  Future<List<Memory>> getMyMemories(String uuid) async {
    final String idToken = await AuthService().getIdToken();
    final List<Memory> myMemories = await fetchMyMemories(uuid, idToken);

    return myMemories;
  }

  /// メモリーの住所を取得
  Future<List<Memory>> getMemoryAddresses(List<Memory> memories) async {
    List<Future<void>> futures = [];

    Future<void> _getAddress(int index) async {
      memories[index].address =
          await getAddressFromLocation(memories[index].location);
    }

    for (int i = 0; i < memories.length; i++) {
      futures.add(_getAddress(i));
    }

    await Future.wait(futures);

    return memories;
  }
}
