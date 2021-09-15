import 'package:flutter/material.dart';
import 'package:memory_share/pages/update_password_page/update_password_view_model.dart';
import 'package:memory_share/utils/toast.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  EmailPasswordBox(
                    iconData: Icons.https_outlined,
                    topText: "現在のパスワード",
                    onChanged: (String password) =>
                        updatePasswordViewModel.changeOldPassword(password),
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  EmailPasswordBox(
                    iconData: Icons.https_outlined,
                    topText: "新しいパスワード",
                    onChanged: (String password) =>
                        updatePasswordViewModel.changeNewPassword(password),
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  EmailPasswordBox(
                    iconData: Icons.https_outlined,
                    topText: "新しいパスワード（確認）",
                    onChanged: (String password) => updatePasswordViewModel
                        .changeNewPasswordForConfirmation(password),
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: SignInUpButton(
                      label: '変更する',
                      onPressed: () async {
                        await updatePasswordViewModel
                            .updatePassword()
                            .then((_) {
                          showCustomToast(
                            context,
                            'パスワードを更新しました',
                            true,
                          );
                          Navigator.pop(context);
                        }).catchError((e) {
                          showCustomToast(context, 'パスワードの更新に失敗しました。', false);
                        });
                      },
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
