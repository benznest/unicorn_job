import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';

class RadioBoxWidget extends StatefulWidget {
  final bool checked;
  final bool readOnly;
  final Function(bool)? onCheck;

  const RadioBoxWidget(
      {Key? key, required this.checked, this.readOnly = false, this.onCheck})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RadioBoxWidgetState();
  }
}

class RadioBoxWidgetState extends State<RadioBoxWidget> {
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
        if(!widget.readOnly) {
          widget.onCheck?.call(!widget.checked);
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
            width: isHover ? 31 : 30,
            height: isHover ? 31 : 30,
            decoration: BoxDecoration(
                color: widget.checked
                    ? MyTheme.PRIMARY
                    : MyTheme.PRIMARY.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: MyTheme.PRIMARY, width: 4)),
            child: Visibility(
                visible: widget.checked,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                )),
          )),
    );
  }
}
