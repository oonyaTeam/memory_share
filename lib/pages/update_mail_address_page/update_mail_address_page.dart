import 'package:flutter/material.dart';
import 'package:memory_share/pages/update_mail_address_page/update_mail_address_view_model.dart';
import 'package:memory_share/utils/toast.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UpdateMailAddressPage extends StatelessWidget {
  const UpdateMailAddressPage({Key? key}) : super(key: key);

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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  EmailPasswordBox(
                    iconData: Icons.email_outlined,
                    topText: "新しいメールアドレス",
                    onChanged: (String email) =>
                        updateMailAddressViewModel.changeNewEmail(email),
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  EmailPasswordBox(
                    iconData: Icons.https_outlined,
                    topText: "パスワード",
                    onChanged: (String password) =>
                        updateMailAddressViewModel.changePassword(password),
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
                        await updateMailAddressViewModel
                            .updateEmail()
                            .then((_) {
                          showCustomToast(context, 'メールアドレスを変更しました', true);
                          Navigator.pop(context);
                        }).catchError((e) {
                          showCustomToast(context, 'メールアドレスの更新に失敗しました', false);
                        });
                      },
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            descriptions1: "目的地の周辺です。\nカメラに切り替えます。",
                            wid: MediaQuery.of(context).size.width,
                            tapEvent1: () {},
                            tapEvent2: () {},
                          );
                        },
                      );
                    },
                    child: const Text("Custom Dialog"),
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
