import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ask_permission_view_model.dart';

class AskPermissionPage extends StatelessWidget {
  const AskPermissionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AskPermissionViewModel(),
      child: Consumer<AskPermissionViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            body: Column(
              children: [
                const Text('Memory Shareを使うには、位置情報の設定を変更する必要があります。'),
                const Text('設定したら、もう一度 Memory Share を開いてください'),
                ElevatedButton(
                  onPressed: () => model.openAppSettings(),
                  child: const Text('スマホの設定画面を開く'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
