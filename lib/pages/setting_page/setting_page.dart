import 'package:flutter/material.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:memory_share/view_models/app_model/app_model.dart';
import 'package:provider/provider.dart';
import 'package:memory_share/theme.dart';

import 'setting_view_model.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();
    return ChangeNotifierProvider(
      create: (_) => SettingViewModel(),
      child: Consumer<SettingViewModel>(
        builder: (context, settingViewModel, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: CustomColors.primary,
            iconTheme: const IconThemeData(color: CustomColors.primary),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(top:14.0,left:24.0),
                  child: const Text(
                      "設定",
                      style: TextStyle(
                      color: CustomColors.primary,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Emailでログインしているユーザーの場合、「メールを変更する」を表示してる
              userModel.isEmailUser()
                  ? Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: const Text('メールアドレス変更'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const UpdateMailAddressPage(),
                          ),
                        );
                      },
                    ),
                  )
                  : Container(),
              // Emailでログインしているユーザーの場合、「パスワードを変更する」を表示してる
              userModel.isEmailUser()
                  ? Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: const Text('パスワード変更'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdatePasswordPage(),
                          ),
                        );
                      },
                    ),
                  )
                  : Container(),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: ListTile(
                  title: const Text(
                    'ログアウト',
                    style: TextStyle(
                      color: Color(
                        0xFFFF4848,
                      ),
                    ),
                  ),
                  onTap: () {
                    settingViewModel.logout().then((_) {
                      //toastの表示
                      showCustomToast(context, 'ログアウトしました', true);
                      // 全ての画面を破棄し、ログイン画面に遷移
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (_) => false,
                      );
                    }).catchError((_) {
                      showCustomToast(context, 'ログアウトに失敗しました', false);
                    });
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
