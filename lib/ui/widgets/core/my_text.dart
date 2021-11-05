import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';

class MyText {
  static style({Color? color, String? fontFamily, double? fontSize}) {
    return TextStyle(
        color: color ?? MyTheme.TEXT_PRIMARY,
        fontFamily: fontFamily ?? "Rubik",
        fontSize: fontSize ?? 18);
  }

  static build(String text,
      {Color? color,
      String? fontFamily,
      double? fontSize,
      TextAlign? textAlign,
      int? maxLines,
      bool selectable = true}) {
    if(selectable) {
      return SelectableText(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
            color: color ?? MyTheme.TEXT_PRIMARY,
            fontFamily: fontFamily ?? "Rubik",
            fontSize: fontSize ?? 18),
      );
    }else{
      return Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
            color: color ?? MyTheme.TEXT_PRIMARY,
            fontFamily: fontFamily ?? "Rubik",
            fontSize: fontSize ?? 18),
      );
    }
  }
}
