import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleTwitterButton extends StatelessWidget {
  const GoogleTwitterButton({
    required this.label,
    required this.onPressed,
    required this.color,
    required this.assetName,
    required this.screenWidth,
    Key? key,
  }) : super(key: key);

  final String label;
  final void Function() onPressed;
  final Color color;
  final String assetName;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 48pxが画面端から、8pxがボタン同士の間隔なので -54 してる
      width: (screenWidth - 56) / 2,
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          primary: color,
          onPrimary: Colors.white,
        ),
        onPressed: () => onPressed(),
        icon: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: SvgPicture.asset(
            assetName,
            width: 18,
            height: 18,
            color: Colors.white,
          ),
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
