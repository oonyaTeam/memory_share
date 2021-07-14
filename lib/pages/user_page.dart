import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("マイページ"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.build_circle),
            iconSize: 36,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  height: 60,
                  width: 400,
                  color: Colors.orangeAccent,
                  child: const Text(
                    "  今  ま  で  の  投  稿  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: GridView.builder(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 3,
          //     ),
          //     itemCount: userModel.myMemories.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Card(
          //         child: Image.network(userModel.myMemories[index].image),
          //       );
          //     },
          //   ),
          // ),
          Text(userModel.myMemories.toString()),
          ElevatedButton(onPressed: () => userModel.getMyMemories(), child: const Text('tap'))
        ],
      ),
    );
  }
}
