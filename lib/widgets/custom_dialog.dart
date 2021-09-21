import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/widgets/widgets.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({
    Key? key,
    required this.descriptions1,
    required this.wid,
    required this.tapEvent1,
    required this.tapEvent2,
  }) : super(key: key);

  final String descriptions1;
  final double wid;
  final void Function() tapEvent1, tapEvent2;

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

  contentBox(context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          width: wid - 48, //dialogの横幅
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: CustomColors.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
              ),
              Container(
                width: (wid - 48) * 0.9,
                margin: const EdgeInsets.only(bottom: 48, top: 64),
                child: Text(
                  descriptions1,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 64,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: CustomColors.light,
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => tapEvent2(),
                        child: const Text(
                          "いいえ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: CustomColors.deep,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 64,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: CustomColors.light,
                            width: 1,
                          ),
                          left: BorderSide(
                            color: CustomColors.light,
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => tapEvent1(),
                        child: const Text(
                          "はい",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
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
        const Positioned(
          top: 118,
          child: Icon(
            Icons.photo_outlined,
            color: CustomColors.primary,
            size: 72,
          ),
        ),
      ],
    );
  }
}
