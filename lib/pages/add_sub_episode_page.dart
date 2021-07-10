import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddSubEpisodePage extends StatefulWidget {
  @override
  _AddSubEpisodePageState createState() => _AddSubEpisodePageState();
}

class _AddSubEpisodePageState extends State<AddSubEpisodePage> {

  TextEditingController _textEditingController;

  String _subEpisode = '';

  void _onChanged(String text) {
    setState(() {
      _subEpisode = text;
    });
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserModel>();
    return Scaffold(
      appBar: EditorAppBar(
        postLabel: "追加する",
        onPost: () => {
          userModel.addSubEpisode(_subEpisode),
          Navigator.of(context).pop()
        },
        onCancel: () => Navigator.of(context).pop(),
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
                controller: _textEditingController,
                onChanged: (String text) => _onChanged(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
