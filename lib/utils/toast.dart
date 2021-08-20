import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memory_share/widgets/widgets.dart';

void showCustomToast(BuildContext context, String text, bool isSuccessed) {
  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: toast(text, isSuccessed),
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2)
  );
}