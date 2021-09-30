import 'package:memory_share/models/models.dart';

class MemoryRepository {
  final MemoryService _memoryService = MemoryService();

  Future<List<Memory>> getMyMemories(String uuid) async {
    final myMemories = await _memoryService.getMyMemories(uuid);
    return _memoryService.getMemoryAddresses(myMemories);
  }
}
