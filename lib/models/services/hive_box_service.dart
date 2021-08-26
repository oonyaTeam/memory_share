import 'package:hive/hive.dart';
import 'package:memory_share/models/models.dart';

class HiveBoxService {
  static const String _userRecordKey = 'user_record';

  final Future<Box<UserRecord>> _box = Hive.openBox('user_record');

  Future<UserRecord> _getUserRecord() async {
    final box = await _box;
    return box.get(
      _userRecordKey,
      defaultValue: UserRecord(
        postTutorialDone: false,
        reExperienceTutorialDone: false,
      ),
    );
  }

  Future<bool> getReExperienceTutorialDone() async {
    final UserRecord userRecord = await _getUserRecord();
    return userRecord.reExperienceTutorialDone;
  }

  Future<bool> getPostTutorialDone() async {
    final UserRecord userRecord = await _getUserRecord();
    return userRecord.postTutorialDone;
  }

  Future<void> putReExperienceTutorialDone() async {
    final box = await _box;
    final UserRecord userRecord = await _getUserRecord();
    await box.put(
      _userRecordKey,
      UserRecord(
        reExperienceTutorialDone: true,
        postTutorialDone: userRecord.postTutorialDone,
      ),
    );
  }

  Future<void> putPostTutorialDone() async {
    final box = await _box;
    final UserRecord userRecord = await _getUserRecord();
    await box.put(
      _userRecordKey,
      UserRecord(
        reExperienceTutorialDone: userRecord.reExperienceTutorialDone,
        postTutorialDone: true,
      ),
    );
  }
}
