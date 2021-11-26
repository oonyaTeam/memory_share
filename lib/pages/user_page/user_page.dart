import 'package:flutter/material.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/utils/utils.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'user_page_view_model.dart';

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
                          MainEpisodeImage(
                            imageUrl: item.image,
                            height: 256,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDateWithSlashes(item.createdAt),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: CustomColors.middle,
                                  ),
                                ),
                                Text(
                                  item.address ?? "",
                                  style: const TextStyle(
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
