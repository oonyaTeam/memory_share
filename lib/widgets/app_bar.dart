import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

Widget appBarComponent(String appBarTitle){
  return AppBar(
    backgroundColor: newTheme().primary,
    title: Text(appBarTitle),
  );
}