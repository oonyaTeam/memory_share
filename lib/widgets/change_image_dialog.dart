import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/widgets/widgets.dart';

class ChangeImageDialog extends StatelessWidget {
  const ChangeImageDialog({
    Key? key,
    required this.imageFile,
    required this.onSubmitted,
    required this.onCanceled,
  }) : super(key: key);

  final File imageFile;
  final void Function() onSubmitted, onCanceled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 346.0,
            child: Image.file(imageFile),
          ),
          const SizedBox(height: 16),
          const DottedLine(
            lineThickness: 4.0,
            lineLength: 346.0,
            dashRadius: 16.0,
            dashGapLength: 3.0,
          ),
          const SizedBox(height: 16),
          LongButton(
            label: "写真を取り直す",
            onPressed: () => onSubmitted(),
          ),
          const SizedBox(height: 16),
          LongButtonBorderPrimary(
            label: "とじる",
            onPressed: () => onCanceled(),
          ),
        ],
      ),
    );
  }
}
