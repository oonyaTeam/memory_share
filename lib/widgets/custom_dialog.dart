import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions1;
  final double wid;
  final Function() tapEvent1, tapEvent2;
  const CustomDialogBox({Key key, this.title, this.descriptions1, this.wid, this.tapEvent1, this.tapEvent2}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          width: widget.wid-48, //dialogの横幅
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: newTheme().primary,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16)),
                  ),
                ),
              Container(
                width: (widget.wid-48)*0.9,
                margin: const EdgeInsets.only(bottom: 48,top: 64),
                child: Text(
                    widget.descriptions1,
                 style: const TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 64,
                width: 170,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: newTheme().light,
                      width: 1,
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: (){
                    widget.tapEvent1;
                  },
                  child: Text(
                      "いいえ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: newTheme().deep,
                      ),
                  ),
                ),
              ),
              Container(
                height: 64,
                width: 170,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: newTheme().light,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: newTheme().light,
                      width: 1,
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: (){
                    widget.tapEvent2;
                  },
                  child: const Text(
                      "はい",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
        Positioned(
          top: 101,
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 118,
          child: Container(
            child: Icon(
              Icons.photo_outlined,
              color: newTheme().primary,
              size: 72,
            ),
          ),
        )
      ],
    );
  }
}