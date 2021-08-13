import 'package:hive/hive.dart';

part 'user_record.g.dart';

@HiveType(typeId: 1)
class UserRecord {
  UserRecord({this.reExperienceTutorialDone, this.postTutorialDone});

  @HiveField(0)
  bool reExperienceTutorialDone = false;
  @HiveField(1)
  bool postTutorialDone = false;
}
