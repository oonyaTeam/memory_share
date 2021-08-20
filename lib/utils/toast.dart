import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memory_share/widgets/widgets.dart';

void showCustomToast(BuildContext context) {
  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: toast(),
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2)
  );
}