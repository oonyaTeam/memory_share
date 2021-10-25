import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

/// 右下以外に表示する FloatingActionButton
///
/// `icon`: ボタン上のアイコン
/// `onPressed`: ボタンタップ時のイベント
class FloatingIconButton extends StatelessWidget {
  const FloatingIconButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 24,
            spreadRadius: 1,
          )
        ],
      ),
      child: IconButton(
        padding: const EdgeInsets.all(16),
        iconSize: 32.0,
        onPressed: onPressed,
        color: CustomColors.primary,
        icon: Icon(icon),
      ),
    );
  }
}
