import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Color? background;

  const CardWidget(
      {Key? key,
      required this.child,
      this.padding,
      this.margin,
      this.borderRadius,
      this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? const EdgeInsets.all(16),
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: background ?? Colors.white,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 6,
                spreadRadius: 2,
                offset:const Offset(0, 2),
              )
            ]),
        child: child);
  }
}
