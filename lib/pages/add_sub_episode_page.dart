import 'package:flutter/material.dart';
import 'package:memory_share/widgets/widgets.dart';

class AddSubEpisodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditorAppBar(
        postLabel: "追加する",
        onPost: () => {},
        onCancel: () => {},
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "Insert your message",
                ),
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
