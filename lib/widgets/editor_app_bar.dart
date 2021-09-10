import 'package:flutter/material.dart';
import 'package:memory_share/widgets/widgets.dart';

class EditorAppBar extends StatelessWidget with PreferredSizeWidget {
  const EditorAppBar({
    Key? key,
    required this.postLabel,
    required this.onCancel,
    required this.onPost,
  }) : super(key: key);

  final String postLabel;
  final void Function() onCancel;
  final void Function() onPost;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 0),
              child: TextButton(
                onPressed: () => onCancel(),
                child: const Text('キャンセル'),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              //margin: EdgeInsets.all(0.0),
              child: variableButton(
                postLabel,
                () => onPost(),
                114.0,
                44.0,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
