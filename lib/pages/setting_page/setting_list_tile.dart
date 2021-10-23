import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(label),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16.0,
          color: Colors.black,
        ),
        onTap: onTap,
      );
}
