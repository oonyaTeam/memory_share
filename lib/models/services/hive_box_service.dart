
import 'package:hive/hive.dart';
import 'package:memory_share/models/models.dart';

class HiveBoxService {
  static const String _userRecordKey = 'user_record';

  final Future<Box<UserRecord>> _box = Hive.openBox('user_record');

  Future<void> putReExperienceTutorialDone () async {
    final box = await _box;
    final UserRecord userRecord = box.get(_userRecordKey);
    await box.put(
      _userRecordKey,
      UserRecord(
        reExperienceTutorialDone: userRecord.reExperienceTutorialDone,
        postTutorialDone: true,
      ),
    );
  }

  Future<void> putPostTutorialDone() async {
    final box = await _box;
    final UserRecord userRecord = box.get(_userRecordKey);
    await box.put(
      _userRecordKey,
      UserRecord(
        reExperienceTutorialDone: userRecord.reExperienceTutorialDone,
        postTutorialDone: true,
      ),
    );
  }

}