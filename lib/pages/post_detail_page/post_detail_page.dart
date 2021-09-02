import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'post_detail_view_model.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage(this.memory, {Key key}) : super(key: key);

  final Memory memory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostDetailViewModel(),
      child: Consumer<PostDetailViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('PostDetail'),
            ),
            body: Container(
              margin: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = memory.episodes[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubEpisodeWrapper(subEpisode: item.episode),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 24.0),
                              child: SvgPicture.asset(
                                'assets/foot_prints.svg',
                                height: 80.0,
                                width: 40.0,
                                color: newTheme().pale,
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: memory.episodes.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Image.network(memory.image),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // ListView.builder(
              //   itemCount: memory.episodes.length,
              //   itemBuilder: (context, index) {
              //     final item = memory.episodes[index];
              //
              //     if (index == memory.episodes.length - 1) {
              //     }
              //
              //   },
              // ),
            ),
          );
        },
      ),
    );
  }
}
