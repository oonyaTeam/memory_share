import 'package:flutter/material.dart';
import 'file:///C:/Users/taku3/work/memory_share/lib/pages/login_page/login_page.dart';
import 'file:///C:/Users/taku3/work/memory_share/lib/pages/update_password_page/update_password_page.dart';
import 'file:///C:/Users/taku3/work/memory_share/lib/pages/update_mail_address_page/update_mail_address_page.dart';
import 'package:memory_share/view_models/setting_view_model.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingViewModel(),
      child: Consumer<SettingViewModel>(
        builder: (context, settingViewModel, _) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("設定"),
          ),
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
                child: ListTile(
                  title: const Text('メールアドレスの変更'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateMailAddressPage()),
                    );
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
                child: ListTile(
                  title: const Text('パスワードの変更'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdatePasswordPage()),
                    );
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
                child: ListTile(
                  title: const Text(
                    'ログアウト',
                    style: TextStyle(
                      color: Color(
                        0xFFFF4848,
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    settingViewModel.logout().then((_) {
                      // 全ての画面を破棄し、ログイン画面に遷移
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (_) => false,
                      );
                    }).catchError((_) {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
