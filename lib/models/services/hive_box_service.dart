import 'package:hive/hive.dart';
import 'package:memory_share/models/models.dart';

class HiveBoxService {
  HiveBoxService() {
    initRecord();
  }

  void initRecord() async {
    _box = await Hive.openBox('user_record');
  }

  static const String _userRecordKey = 'user_record';

  Box<UserRecord> _box;

  bool getReExperienceTutorialDone() {
    final UserRecord userRecord = _box.get(_userRecordKey);
    return userRecord.reExperienceTutorialDone;
  }

  bool getPostTutorialDone() {
    final UserRecord userRecord = _box.get(_userRecordKey);
    return userRecord.postTutorialDone;
  }

  Future<void> putReExperienceTutorialDone() async {
    final UserRecord userRecord = _box.get(_userRecordKey);
    await _box.put(
      _userRecordKey,
      UserRecord(
        reExperienceTutorialDone: userRecord.reExperienceTutorialDone,
        postTutorialDone: true,
      ),
    );
  }

  Future<void> putPostTutorialDone() async {
    final UserRecord userRecord = _box.get(_userRecordKey);
    await _box.put(
      _userRecordKey,
      UserRecord(
        reExperienceTutorialDone: userRecord.reExperienceTutorialDone,
        postTutorialDone: true,
      ),
    );
  }
}
