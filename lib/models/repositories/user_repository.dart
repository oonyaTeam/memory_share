import 'package:memory_share/models/services/services.dart';

class UserRepository {
  UserRepository();

  final HiveBoxService _hiveBoxService = HiveBoxService();

  Future<void> reExperienceTutorialIsFinished() async {
    _hiveBoxService.putReExperienceTutorialDone();
  }

  Future<void> postTutorialIsFinished() async {
    _hiveBoxService.putPostTutorialDone();
  }
}
