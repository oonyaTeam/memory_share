import 'package:flutter/material.dart';
import 'package:memory_share/pages/re_experience_page/re_experience_view_model.dart';
import 'package:provider/provider.dart';

class ReExperienceTutorialPage extends StatelessWidget {
  const ReExperienceTutorialPage(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReExperienceViewModel(),
      child: Consumer<ReExperienceViewModel>(
        builder: (context, addSubEpisodeViewModel, _) => Scaffold(
          body: Container(),
        ),
      ),
    );
  }
}
