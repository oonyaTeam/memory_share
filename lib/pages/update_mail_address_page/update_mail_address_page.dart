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
          backgroundColor: Colors.white,
          body: CustomScrollView(
            controller: updateMailAddressViewModel.controller,
            slivers: [
              CustomSliverAppBar(
                controller: updateMailAddressViewModel.controller,
                title: "メールアドレスの変更",
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 48,
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
                                showCustomToast(
                                    context, 'メールアドレスを変更しました', true);
                                Navigator.pop(context);
                              }).catchError((e) {
                                showCustomToast(
                                    context, 'メールアドレスの更新に失敗しました', false);
                              });
                            },
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
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
