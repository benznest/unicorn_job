import 'package:flutter/material.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/ui/widgets/task_option_widget.dart';

class TaskOptionDialog extends StatefulWidget {
  const TaskOptionDialog({Key? key}) : super(key: key);

  static show(
    BuildContext context,
  ) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        barrierColor: Colors.grey[700]!.withOpacity(0.5),
        builder: (context) => TaskOptionDialog());
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
              child: Container(
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
            ),
          ),
        ));
  }

  Widget buildContent(BuildContext context) {
    return Wrap(
      spacing: 8,runSpacing: 8,
      children: [
        TaskOptionWidget(
          title: "Launch!",
          subtitle: "Run the command immediately.",
          icon: "assets/images/ic_launch.png",
          background: MyTheme.ACCENT.withOpacity(0.1),
          backgroundHover: MyTheme.ACCENT.withOpacity(0.8),
          textColor: Colors.grey[800],
          textColorHover: Colors.white,
        ),
        TaskOptionWidget(
          title: "Skip",
          subtitle: "Skip to the next time.",
          icon: "assets/images/ic_skip.png",
          background: MyTheme.ACCENT.withOpacity(0.1),
          backgroundHover: MyTheme.ACCENT.withOpacity(0.8),
          textColor: Colors.grey[800],
          textColorHover: Colors.white,
        ),
      ],
    );
  }

}
