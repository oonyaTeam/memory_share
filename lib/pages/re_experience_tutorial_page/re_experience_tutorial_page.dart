import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 're_experience_tutorial_view_model.dart';

class ReExperienceTutorialPage extends StatelessWidget {
  const ReExperienceTutorialPage(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReExperienceTutorialViewModel(),
      child: Consumer<ReExperienceTutorialViewModel>(
        builder: (context, model, _) => Scaffold(
          body: Container(),
        ),
      ),
    );
  }
}
