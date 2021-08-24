import 'package:flutter/material.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("マイページ"),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.settings),
      //       iconSize: 36,
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => const SettingPage()),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('これまでの投稿', textScaleFactor: 1),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                iconSize: 36,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()),
                  );
                },
              ),
            ],
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16.0);
            },
            itemCount: userModel.myMemories.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Image.network(userModel.myMemories[index].image),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "2021/08/16",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: newTheme().middle,
                          ),
                        ),
                        Text(
                          "東京都渋谷区",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: newTheme().middle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
