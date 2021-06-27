import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Color emoColor = Color.fromARGB(255, 233, 103, 75);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '思い出を投稿',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ButtonTheme(
              minWidth: 346.0,
              height: 56.0,
              child: Container(
                margin: EdgeInsets.only(top: 522.0),
                child: RaisedButton(
                  shape: const StadiumBorder(),
                  textColor: Colors.white,
                  color: emoColor,
                  child: Text(
                    "エピソードを追加する",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 346.0,
              height: 56.0,
              child: Container(
                margin: EdgeInsets.only(top: 11.0),
                child: RaisedButton(
                  shape: const StadiumBorder(),
                  textColor: Colors.white,
                  color: emoColor,
                  child: Text(
                    "目的地に到着",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => {print("うんち")},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
