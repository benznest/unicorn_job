import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task_storage.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/my_text.dart';
import 'package:unicorn_app_scheduler/ui/widgets/task_item_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          centerTitle: true,
          title:
              MyText.build("TASK", fontSize: 24, fontFamily: "Rubik-Bold"),
        ),
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: Hive.box(TaskStorage.key).listenable(),
              builder: (context, box, widget) {
                List<Task> listTasks = TaskStorage.get();
                return ListView.builder(
                  itemCount: listTasks.length,
                  padding: const EdgeInsets.all(32),
                  itemBuilder: (context, index) {
                    return TaskItemWidget(
                      task: listTasks[index],
                      // onTap: (job) {
                        // JobFormDialog.show(context, initJob: job,
                        //     onJobUpdated: (j) {
                        //       MySnackBarUtil.showSuccess(context,
                        //           message: "Job \"${job.title}\" is updated.");
                        //     }, onJobDeleted: (j) {
                        //       MySnackBarUtil.showSuccess(context,
                        //           message: "Job \"${job.title}\" is deleted.");
                        //     });
                      // },
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
