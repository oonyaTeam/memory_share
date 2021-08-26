import 'package:memory_share/models/services/services.dart';

class UserRepository {
  UserRepository();

  final HiveBoxService _hiveBoxService = HiveBoxService();

  bool getReExperienceTutorialDone() =>
      _hiveBoxService.getReExperienceTutorialDone();

  bool getPostTutorialDone() => _hiveBoxService.getPostTutorialDone();

  Future<void> reExperienceTutorialIsFinished() async {
    await _hiveBoxService.putReExperienceTutorialDone();
  }

  Future<void> postTutorialIsFinished() async {
    await _hiveBoxService.putPostTutorialDone();
  }
}
