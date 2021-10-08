import 'package:flutter/material.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/pages/setting_page/setting_list_tile.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
          backgroundColor: Colors.white,
          body: CustomScrollView(
            controller: settingViewModel.controller,
            slivers: [
              CustomSliverAppBar(
                controller: settingViewModel.controller,
                title: "設定",
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  // Emailでログインしているユーザーの場合、「メールアドレスを変更する」「パスワードを変更する」を表示してる
                  // 配列と、スプレッド演算子を用いている
                  if (userModel.isEmailUser()) ...[
                    SettingListTile(
                      label: 'メールアドレス変更',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdateMailAddressPage(),
                          ),
                        );
                      },
                    ),
                    SettingListTile(
                      label: 'パスワード変更',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdatePasswordPage(),
                          ),
                        );
                      },
                    ),
                  ],
                  ListTile(
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
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
