import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_image_asset.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task_manager.dart';
import 'package:unicorn_app_scheduler/ui/widgets/task_option_widget.dart';

class TaskOptionDialog extends StatefulWidget {
  final Task task;

  const TaskOptionDialog({Key? key, required this.task}) : super(key: key);

  static show(BuildContext context, {required Task task}) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        barrierColor: Colors.grey[700]!.withOpacity(0.5),
        builder: (context) => TaskOptionDialog(task: task));
  }

  @override
  _TaskOptionDialogState createState() => _TaskOptionDialogState();
}

class _TaskOptionDialogState extends State<TaskOptionDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {
                //
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        margin: const EdgeInsets.only(left: 300),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: MyTheme.BACKGROUND_PRIMARY,
                          borderRadius: BorderRadius.circular(22)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildContent(context),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildContent(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        TaskOptionWidget(
          title: "Launch!",
          subtitle: "Run the command immediately.",
          icon: MyImageAsset.launch,
          background: MyTheme.ACCENT.withOpacity(0.1),
          backgroundHover: MyTheme.ACCENT.withOpacity(0.8),
          textColor: Colors.grey[800],
          textColorHover: Colors.white,
          onTap: () {
            TaskManager.launch(widget.task);
            Navigator.pop(context);
          },
        ),
        TaskOptionWidget(
          title: "Skip",
          subtitle: "Skip to the next time.",
          icon: MyImageAsset.skip,
          background: MyTheme.ACCENT.withOpacity(0.1),
          backgroundHover: MyTheme.ACCENT.withOpacity(0.8),
          textColor: Colors.grey[800],
          textColorHover: Colors.white,
          onTap: () {
            TaskManager.launch(widget.task, skip: true);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
