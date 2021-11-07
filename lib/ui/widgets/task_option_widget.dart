import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_repetition.dart';
import 'package:unicorn_app_scheduler/ui/dialogs/job_form_dialog.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/button_icon_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/utils/my_date_utils.dart';

class TaskOptionWidget extends StatefulWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color? background;
  final Color? backgroundHover;
  final Color? textColor;
  final Color? textColorHover;
  final Function()? onTap;

  const TaskOptionWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.onTap,
      this.background,
      this.backgroundHover,
      this.textColor,
      this.textColorHover})
      : super(key: key);

  @override
  _TaskOptionWidgetState createState() => _TaskOptionWidgetState();
}

class _TaskOptionWidgetState extends State<TaskOptionWidget> {
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
              width: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: getBackground(),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Image.asset(
                    widget.icon,
                    width: 60,
                  ),
                  MyText.build(widget.title, fontSize: 18, selectable: false,
                  color: getTextColor()),
                  const SizedBox(
                    height: 4,
                  ),
                  MyText.build(widget.subtitle,
                      fontSize: 12,
                      selectable: false,
                      textAlign: TextAlign.center,
                      color: getTextColor().withOpacity(0.7)),
                ],
              ),
            )));
  }

  getBackground() {
    if (isHover) {
      return widget.backgroundHover ?? Colors.grey[100];
    } else {
      return widget.background ?? Colors.grey[100];
    }
  }
  Color getTextColor() {
    if (isHover) {
      return widget.textColorHover ?? Colors.grey[700]!.withOpacity(1);
    } else {
      return widget.textColor ?? Colors.grey[700]!.withOpacity(1);
    }
  }
}
