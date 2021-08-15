import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/models/services/services.dart';

class UserRepository {
  UserRepository();

  final HiveBoxService _hiveBoxService = HiveBoxService();

  Future<void> reExperienceTutorialIsFinished() async {
    _hiveBoxService.putReExperienceTutorialDone();
  }

  Future<void> postTutorialIsFinished(UserRecord record) async {
    _hiveBoxService.putPostTutorialDone();
  }
}
