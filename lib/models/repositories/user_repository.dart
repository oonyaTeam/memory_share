import 'package:memory_share/models/models.dart';

/// Userに関する処理をまとめたRepository
class UserRepository {
  UserRepository();

  final HiveBoxService _hiveBoxService = HiveBoxService();

  final CoreService _coreService = CoreService();

  Future<bool> getReExperienceTutorialDone() async =>
      await _hiveBoxService.getReExperienceTutorialDone();

  Future<bool> getPostTutorialDone() async =>
      await _hiveBoxService.getPostTutorialDone();

  Future<void> reExperienceTutorialIsFinished() async {
    await _hiveBoxService.putReExperienceTutorialDone();
  }

  Future<void> postTutorialIsFinished() async {
    await _hiveBoxService.putPostTutorialDone();
  }

  Future<void> viblate() async => await _coreService.viblate();
}
