import 'package:hive/hive.dart';
import 'package:memory_share/models/entities/entities.dart';

class HiveBoxRepository {
  HiveBoxRepository();

  static const String userRecordKey = 'user_record';
  final Future<Box<UserRecord>> _box = Hive.openBox('user_record');

  Future<void> saveReExperienceTutorialDone(UserRecord record) async {
    final box = await _box;
    await box.put(
      userRecordKey,
      UserRecord(
        reExperienceTutorialDone: true,
        postTutorialDone: record.postTutorialDone,
      ),
    );
  }

  Future<void> save(UserRecord record) async {
    final box = await _box;
    await box.put(
      userRecordKey,
      UserRecord(
        reExperienceTutorialDone: record.reExperienceTutorialDone,
        postTutorialDone: true,
      ),
    );
  }
}
