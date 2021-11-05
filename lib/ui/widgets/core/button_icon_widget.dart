import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';

class ButtonIconWidget extends StatefulWidget {
  final IconData icon;
  final Color textColor;
  final Color? background;
  final Color? backgroundHover;
  final String title;
  final double? fontSize;
  final double? spaceBetweenIconText;
  final EdgeInsets? padding;
  final Function()? onTap;

  ButtonIconWidget(
      {required this.icon,
      required this.textColor,
      required this.title,
      this.padding,
      this.fontSize,
      this.spaceBetweenIconText,
      this.background,
      this.backgroundHover,
      this.onTap});

  @override
  _ButtonIconWidgetState createState() => _ButtonIconWidgetState();
}

class _ButtonIconWidgetState extends State<ButtonIconWidget> {
  late bool isHover;

  @override
  void initState() {
    isHover = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (e) {
          setState(() {
            isHover = false;
          });
        },
        child: Container(
          padding: widget.padding ?? EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: getBackground(), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.textColor,
              ),
              SizedBox(width: widget.spaceBetweenIconText ?? 8),
              MyText.build(widget.title,
                  fontSize: widget.fontSize ?? 18,
                  color: widget.textColor,
                  selectable: false),
              SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }

  Color? getBackground() {
    if (isHover) {
      return widget.backgroundHover ?? Colors.white.withOpacity(0.1);
    } else {
      return widget.background ?? Colors.white.withOpacity(0.05);
    }
  }
}
