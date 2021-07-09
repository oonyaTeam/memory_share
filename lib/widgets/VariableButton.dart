import 'package:flutter/material.dart';

Widget VariableButton(String buttonText, Function() tappedEvent, double width, double height){
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        onPrimary: Colors.white,
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => {
        tappedEvent(),
      },

    ),
  );
}