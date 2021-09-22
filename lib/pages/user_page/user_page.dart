import 'package:flutter/material.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/pages/post_detail_page/post_detail_page.dart';
import 'package:memory_share/pages/user_page/user_page_view_model.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();
    return ChangeNotifierProvider(
      create: (_) => UserPageViewModel(),
      child: Consumer<UserPageViewModel>(
        builder: (context, model, _) => Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            controller: model.controller,
            slivers: [
              CustomSliverAppBar(
                controller: model.controller,
                title: "これまでの投稿",
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.settings),
                    iconSize: 36,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = userModel.myMemories[index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PostDetailPage(item)),
                      ),
                      child: Column(
                        children: [
                          Image.network(item.image),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "2021/08/16", // TODO: APIができ次第ここも変える
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: CustomColors.middle,
                                  ),
                                ),
                                Text(
                                  "東京都渋谷区",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: CustomColors.middle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    );
                  },
                  childCount: userModel.myMemories.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
