import 'package:flutter/material.dart';
import 'package:memory_share/pages/post_tutorial_page/post_tutorial_view_model.dart';
import 'package:provider/provider.dart';

class PostTutorialPage extends StatelessWidget {
  const PostTutorialPage(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostTutorialViewModel(),
      child: Consumer<PostTutorialViewModel>(
        builder: (context, addSubEpisodeViewModel, _) => Scaffold(
          body: Container(),
        ),
      ),
    );
  }
}
