import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';

class MySnackBarUtil {
  static showDanger(BuildContext context, {required String message}) {
    show(context, message: message, background: MyTheme.DANGER);
  }
  static showSuccess(BuildContext context, {required String message}) {
    show(context, message: message, background: MyTheme.SUCCESS);
  }

  static show(BuildContext context, {required String message, Color? background}) {
    SnackBar snackBar = SnackBar(
      content: MyText.build(message,color: Colors.white),
      backgroundColor: background,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
