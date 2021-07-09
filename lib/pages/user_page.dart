import 'package:flutter/material.dart';
import 'package:memory_share/pages/setting_page.dart';


class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("マイページ"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.build_circle),
            iconSize: 36,
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));}
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
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  height: 60,
                  width: 400,
                  color: Colors.orangeAccent,
                  child:
                  Text(
                    "  今  ま  で  の  投  稿  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                    ) ,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/hukura.jpg'),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/hukura.jpg'),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/muscle.jpg'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}