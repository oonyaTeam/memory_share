import 'package:flutter/material.dart';
import 'update_password_view_model.dart';
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
              const SizedBox(
                height: 24,
              ),
              emailPasswordBox(
                iconData: Icons.https_outlined,
                topText: "現在のパスワード",
                onChanged: (String password) =>
                    updatePasswordViewModel.changeOldPassword(password),
              ),
              const SizedBox(
                height: 4,
              ),
              emailPasswordBox(
                iconData: Icons.https_outlined,
                topText: "新しいパスワード",
                onChanged: (String password) =>
                    updatePasswordViewModel.changeNewPassword(password),
              ),
              const SizedBox(
                height: 4,
              ),
              emailPasswordBox(
                iconData: Icons.https_outlined,
                topText: "新しいパスワード（確認）",
                onChanged: (String password) => updatePasswordViewModel
                    .changeNewPasswordForConfirmation(password),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: signInUpButton(
                  '変更する',
                  () async {
                    await updatePasswordViewModel
                        .updatePassword()
                        .then((_) => Navigator.pop(context))
                        .catchError((e) {});
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