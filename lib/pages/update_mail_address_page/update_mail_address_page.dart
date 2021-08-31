import 'package:flutter/material.dart';
import 'package:memory_share/pages/update_mail_address_page/update_mail_address_view_model.dart';
import 'package:memory_share/utils/toast.dart';
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
              const SizedBox(
                height: 24,
              ),
              emailPasswordBox(
                iconData: Icons.email_outlined,
                topText: "新しいメールアドレス",
                onChanged: (String email) =>
                    updateMailAddressViewModel.changeNewEmail(email),
              ),
              const SizedBox(
                height: 4,
              ),
              emailPasswordBox(
                iconData: Icons.https_outlined,
                topText: "パスワード",
                onChanged: (String password) =>
                    updateMailAddressViewModel.changePassword(password),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: signInUpButton(
                  '変更する',
                  () async {
                    await updateMailAddressViewModel
                        .updateEmail()
                        .then((_) => {
                          showCustomToast(context, 'メールアドレスを変更しました', true),
                          Navigator.pop(context)
                    })
                        .catchError((e) {
                          showCustomToast(context, 'メールアドレスの更新に失敗しました', false);
                    });
                  },
                  MediaQuery.of(context).size.width
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    showDialog(context: context,
                        builder: (BuildContext context){
                          return const CustomDialogBox(
                            title: "custom_dialog",
                            descriptions1: "目的地の周辺です。　　　カメラに切り替えます。",
                            text: "yes",
                          );
                        }
                    );
                  },
                  child: const Text("Custom Dialog"),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
