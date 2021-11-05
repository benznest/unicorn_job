import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  const CardWidget({Key? key, required this.child,this.padding,this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:borderRadius?? BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 6,spreadRadius: 2,
                  offset: Offset(0, 2),
              )
            ]),
        child: child);
  }
}
