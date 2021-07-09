import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SettingPage"),
      ),
      body: Column(
        children: [
          Container(
              child:IconButton(
                  icon: Icon(Icons.build_circle),
                  iconSize: 36,
                  onPressed: () {}
              ),
          ),
        ],
      ),
    );
  }
}