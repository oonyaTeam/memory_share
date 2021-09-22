import 'package:flutter/material.dart';
import 'package:memory_share/pages/update_mail_address_page/update_mail_address_view_model.dart';
import 'package:memory_share/utils/toast.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:memory_share/theme.dart';

class UpdateMailAddressPage extends StatelessWidget {
  const UpdateMailAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UpdateMailAddressViewModel(),
      child: Consumer<UpdateMailAddressViewModel>(
        builder: (context, updateMailAddressViewModel, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: CustomColors.primary,
            iconTheme: const IconThemeData(color: CustomColors.primary),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top:14.0,left:24.0),
                      child: const Text(
                        "メールアドレスの変更",
                        style: TextStyle(
                          color: CustomColors.primary,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  EmailPasswordBox(
                    iconData: Icons.email_outlined,
                    topText: "新しいメールアドレス",
                    onChanged: (String email) =>
                        updateMailAddressViewModel.changeNewEmail(email),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
