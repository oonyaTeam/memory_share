import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'post_detail_view_model.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage(this.memory, {Key? key}) : super(key: key);

  final Memory memory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostDetailViewModel(),
      child: Consumer<PostDetailViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              controller: model.controller,
              slivers: [
                CustomSliverAppBar(
                  controller: model.controller,
                  title: memory.address ?? "",
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = memory.episodes[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubEpisodeWrapper(item.episode),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                                left: 24.0,
                              ),
                              child: Transform.rotate(
                                angle: pi,
                                child: SvgPicture.asset(
                                  'assets/foot_prints.svg',
                                  height: 80.0,
                                  width: 40.0,
                                  color: CustomColors.pale,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: memory.episodes.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 16.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CustomColors.pale,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            child: MainEpisodeImage(
                              imageUrl: memory.image,
                              height: 256,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              memory.memory,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
