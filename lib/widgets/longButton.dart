import 'package:flutter/material.dart';

Widget longButton(String buttonText, Function() tappedEvent){
  return ButtonTheme(
    minWidth: 346.0,
    height: 56.0,
    child: Container(
      margin: EdgeInsets.only(top: 11.0),
      child: RaisedButton(
        shape: const StadiumBorder(),
        textColor: Colors.white,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => {
          tappedEvent(),
        },
      ),
    ),
  );
}
