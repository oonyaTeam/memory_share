import 'package:hive/hive.dart';

part 'user_record.g.dart';

/// 永続化する際にも使用するので、HiveTypeをつけてHIveで扱えるようにしてる。
@HiveType(typeId: 1)
class UserRecord {
  UserRecord({
    required this.reExperienceTutorialDone,
    required this.postTutorialDone,
  });

  // 閲覧のチュートリアルを見たかどうかのbool値
  @HiveField(0)
  bool reExperienceTutorialDone;

  // 投稿のチュートリアルを見たかどうかのbool値
  @HiveField(1)
  bool postTutorialDone;
}
