import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';

class ButtonIconWidget extends StatefulWidget {
  final Color color;
  final Color? background;
  final Color? backgroundHover;
  final String? title;
  final double? fontSize;
  final IconData? iconFront;
  final double? spaceBetweenIconTextFront;
  final IconData? iconTrail;
  final double? spaceBetweenIconTextTrail;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Function()? onTap;
  final bool readOnly;

  ButtonIconWidget(
      {required this.color,
      this.title,
      this.iconFront,
      this.margin,
      this.padding,
      this.fontSize,
      this.spaceBetweenIconTextFront,
      this.iconTrail,
      this.spaceBetweenIconTextTrail,
      this.background,
      this.backgroundHover,
      this.readOnly = false,
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
    return Container(
      margin: widget.margin,
      child: GestureDetector(
        onTap: () {
          if (!widget.readOnly) {
            widget.onTap?.call();
          }
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
            padding: widget.padding ?? const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: getBackground(),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.iconFront != null)
                  Icon(
                    widget.iconFront,
                    color: widget.color,
                  ),
                if (widget.iconFront != null)
                  SizedBox(width: widget.spaceBetweenIconTextFront ?? 6),
                if (widget.title != null)
                  MyText.build(widget.title!,
                      fontSize: widget.fontSize ?? 18,
                      color: widget.color,
                      selectable: false),
                if (widget.iconTrail != null)
                  SizedBox(width: widget.spaceBetweenIconTextTrail ?? 6),
                if (widget.iconTrail != null)
                  Icon(
                    widget.iconTrail,
                    color: widget.color,
                  ),
              ],
            ),
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
