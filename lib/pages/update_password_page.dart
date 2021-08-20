import 'package:flutter/material.dart';
import 'package:memory_share/utils/toast.dart';
import 'package:memory_share/view_models/update_password_view_model.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UpdatePasswordViewModel(),
      child: Consumer<UpdatePasswordViewModel>(
        builder: (context, updatePasswordViewModel, _) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("メールアドレスの変更"),
          ),
          body: Column(
            children: [
              textBox(
                Icons.https_outlined,
                "現在のパスワード",
                (String password) =>
                    updatePasswordViewModel.changeOldPassword(password),
              ),
              textBox(
                Icons.https_outlined,
                "新しいパスワード",
                (String password) =>
                    updatePasswordViewModel.changeNewPassword(password),
              ),
              textBox(
                Icons.https_outlined,
                "新しいパスワード（確認）",
                (String password) => updatePasswordViewModel
                    .changeNewPasswordForConfirmation(password),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: signInUpButton(
                  '変更する',
                  () async {
                    await updatePasswordViewModel
                        .updatePassword()
                        .then((_) => {
                          showCustomToast(context, 'パスワードを更新しました', true),
                          Navigator.pop(context)
                        })
                        .catchError((e) {
                          showCustomToast(context, 'パスワードの更新に失敗しました。', false);
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
