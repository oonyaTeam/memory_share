import 'package:flutter/material.dart';
import 'package:memory_share/view_models/update_mail_address_view_model.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UpdateMailAddressPage extends StatelessWidget {
  const UpdateMailAddressPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UpdateMailAddressViewModel(),
      child: Consumer<UpdateMailAddressViewModel>(
        builder: (context, updateMailAddressViewModel, _) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("メールアドレスの変更"),
          ),
          body: Column(
            children: [
              textBox(
                Icons.email_outlined,
                "新しいメールアドレス",
                (String email) =>
                    updateMailAddressViewModel.changeNewEmail(email),
              ),
              textBox(
                Icons.https_outlined,
                "パスワード",
                (String password) =>
                    updateMailAddressViewModel.changePassword(password),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: signInUpButton(
                  '変更する',
                  () async {
                    await updateMailAddressViewModel
                        .updateEmail()
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
