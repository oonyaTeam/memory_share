import 'package:flutter/material.dart';
import 'package:memory_share/pages/address_page.dart';
import 'package:memory_share/pages/password_page.dart';

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
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: new BorderSide(color: Colors.black),
                ),
              ),
              child: ListTile(
                title: Text('メールアドレスの変更'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddressPage()));
                  }
              )
          ),
          Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: new BorderSide(color: Colors.black),
                ),
              ),
              child: ListTile(
                  title: Text('パスワードの変更'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordPage()));
                  }
              )
          ),
          Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: new BorderSide(color: Colors.black),
                ),
              ),
              child: ListTile(
                  title: Text('ログアウト'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap:(){}
              )
          ),
        ],
      ),
    );
  }
}