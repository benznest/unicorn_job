import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task.dart';
import 'package:unicorn_app_scheduler/ui/dialogs/task_option_dialog.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/button_icon_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/utils/my_date_utils.dart';

class TaskItemWidget extends StatefulWidget {
  final Task task;

  const TaskItemWidget({Key? key, required this.task}) : super(key: key);

  @override
  _TaskItemWidgetState createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  Timer? _timer;
  DateTime now = DateTime.now();
  bool isHover = false;

  @override
  void initState() {
    if (now.isBefore(widget.task.dateTime)) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        now = DateTime.now();
        setState(() {
          //
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
        child: Opacity(
          opacity: getOpacity(),
          child: CardWidget(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    buildStatusIcon(),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.build(
                              "${widget.task.title} (${widget.task.number})",
                              fontSize: 16),
                          const SizedBox(
                            height: 4,
                          ),
                          MyText.build(
                              MyDateUtil.displayDateTime(widget.task.dateTime),
                              fontSize: 14,
                              color: Colors.grey),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (!widget.task.launched)
                      ButtonIconWidget(
                        iconFront: Icons.settings,
                        color: MyTheme.ACCENT,
                        background: MyTheme.ACCENT.withOpacity(0.1),
                        backgroundHover: MyTheme.ACCENT.withOpacity(0.2),
                        spaceBetweenIconTextFront: 0,
                        onTap: () {
                          TaskOptionDialog.show(context);
                        },
                      ),
                    if (widget.task.launched)
                      ButtonIconWidget(
                        iconFront: Icons.delete,
                        color: MyTheme.DANGER,
                        background: MyTheme.DANGER.withOpacity(0.1),
                        backgroundHover: MyTheme.DANGER.withOpacity(0.2),
                        spaceBetweenIconTextFront: 0,
                        onTap: () {
                          widget.task.delete();
                        },
                      )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.purple[50],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.build(
                          "Working directory",
                          fontSize: 12,
                          color: Colors.purple[200],
                          selectable: false,
                        ),
                        MyText.build(
                          widget.task.workingDirectory,
                          fontSize: 16,
                          color: Colors.purple[600],
                          selectable: false,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 4,
                ),
                Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.build(
                          "Command",
                          fontSize: 12,
                          color: Colors.blueGrey[200],
                          selectable: false,
                        ),
                        MyText.build(
                          widget.task.commands,
                          fontSize: 16,
                          color: Colors.blueGrey[900],
                          selectable: false,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 4,
                ),
                if (widget.task.dateTime.isAfter(now))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: MyTheme.DANGER.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: MyText.build(
                            "${MyDateUtil.displayDiff(widget.task.dateTime.difference(now).inSeconds)} left",
                            fontSize: 14,
                            color: MyTheme.DANGER,
                            selectable: false,
                          )),
                    ],
                  )
              ],
            ),
          ),
        ));
  }

  Container buildStatusIcon() {
    bool launch = widget.task.launched;
    if (launch) {
      return Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.lightGreen.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12)),
          child: Image.asset(
            "assets/images/ic_rocket_launch.png",
            width: 40,
          ));
    } else {
      if (widget.task.dateTime.isBefore(now)) {
        return Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Image.asset(
              "assets/images/ic_rocket_error.png",
              width: 40,
            ));
      } else {
        return Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Image.asset(
              "assets/images/ic_timer.png",
              width: 40,
            ));
      }
    }
  }

  double getOpacity() {
    if (widget.task.launched) {
      if (isHover) {
        return 0.9;
      } else {
        return 0.5;
      }
    } else {
      return 1.0;
    }
  }
}
