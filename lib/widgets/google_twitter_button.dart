import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Widget googleTwitterButton(String buttonText, Function() tappedEvent, Color primaryColor, String setSvg, double screenWidth){
  return SizedBox(
    // 48pxが画面端から、8pxがボタン同士の間隔なので -54 してる
    width: ( screenWidth - 56 ) / 2,
    height: 48,
  child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            primary: primaryColor,
            onPrimary: Colors.white,
          ),
          onPressed: () => {
            tappedEvent()
          },
          icon: Padding(
            padding: const EdgeInsets.only(right:18),
            child: SvgPicture.asset(
                setSvg,
              width: 18,
              height: 18,
              color: Colors.white,
            ),
          ),
          label:
          Text(
            buttonText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
      )
    );
}