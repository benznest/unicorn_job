import 'package:flutter/material.dart';

class MyTextFieldBuilder {
  static Widget buildTextCollapse(
      {TextEditingController? controller,
      String hintText = "",
      Color? colorHint,
      Function(String)? onTextChanged,
      Function(String)? onSubmitted,
      Color? textColor,
      Color? background,
      double? fontSize,
      int minLine = 1,
      int maxLine = 1,
      bool obscureText = false,
      FontWeight? fontWeight,
      FocusNode? focusNode,
      TextAlign textAlign = TextAlign.start,
      bool readOnly = false}) {
    return Container(
        padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: background ?? Colors.purple[50],
    borderRadius: BorderRadius.circular(12)),
    child:TextField(
      controller: controller,
      onChanged: onTextChanged,
      minLines: minLine,
      maxLines: maxLine < minLine ? minLine : maxLine,
      obscureText: obscureText,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      textAlign: textAlign,
      readOnly: readOnly,
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(2),
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: "Rubik",
              color: colorHint,
              letterSpacing: .5,
              fontSize: fontSize,
              fontWeight: fontWeight)),
      style: TextStyle(
          fontFamily: "Rubik",
          color: textColor,
          letterSpacing: .5,
          fontSize: fontSize,
          fontWeight: fontWeight),
    ));
  }
}
