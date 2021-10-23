import 'package:hive/hive.dart';
import 'package:memory_share/models/models.dart';

/// Hiveを使用した永続化に関するServiceです。
/// [UserRecord]型のBoxを扱っています。
class HiveBoxService {
  /// Box内のデータを入れておく場所のキー
  static const String _userRecordKey = 'user_record';

  final Future<Box<UserRecord>> _box = Hive.openBox('user_record');

  /// HiveのBoxからデータを取り出す処理を書いています。[UserRecord]は1つしか持たないので、
  /// 定数で持っている[_userRecordKey]をキーとしてアクセスしています。
  /// 初回起動時などまだデータが保存されていないときのために、defaultValueを指定しています。
  /// 最初はどのチュートリアルも見ていない状態なので、両方falseを入れています。
  Future<UserRecord> _getUserRecord() async {
    final box = await _box;

    /// 本来不要だけど、 Null Safetyの影響でdefaultValueを指定してもnullable型になるので、
    /// ?? UserRecord() を付けた。
    return box.get(
          _userRecordKey,
          defaultValue: UserRecord(
            postTutorialDone: false,
            reExperienceTutorialDone: false,
          ),
        ) ??
        UserRecord(
          postTutorialDone: false,
          reExperienceTutorialDone: false,
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
