import 'package:flutter/material.dart';

class MenuItemWidget extends StatefulWidget {
  final String icon;
  final String title;
  final bool displayTitle;
  final bool isSelected;
  final Function()? onTap;

   const MenuItemWidget(
      {Key? key, required this.icon,
      required this.title,
      this.displayTitle = true,
      this.isSelected = false,
      this.onTap}) : super(key: key);

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
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
        child:
        Container(
          padding: const EdgeInsets.all(6),
          margin:const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
              color: getBackground(),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Image.asset(
                widget.icon,
                width: 40,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? getBackground() {
    if (widget.isSelected) {
      if (isHover) {
        return Colors.lightBlue.withOpacity(0.2);
      } else {
        return Colors.lightBlue.withOpacity(0.1);
      }
    } else {
      if (isHover) {
        return Colors.lightBlue.withOpacity(0.2);
      } else {
        return null;
      }
    }
  }
}
