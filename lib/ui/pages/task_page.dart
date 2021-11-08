import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicorn_app_scheduler/my_theme.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task_storage.dart';
import 'package:unicorn_app_scheduler/ui/widgets/core/card_widget.dart';
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
          title: MyText.build("TASK", fontSize: 24, fontFamily: "Rubik-Bold"),
        ),
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: Hive.box(TaskStorage.key).listenable(),
              builder: (context, box, widget) {
                List<Task> listTasks = TaskStorage.get();
                if (listTasks.isEmpty) {
                  return buildNoData();
                }
                return ListView.builder(
                  itemCount: listTasks.length,
                  padding: const EdgeInsets.all(32),
                  itemBuilder: (context, index) {
                    return TaskItemWidget(
                      task: listTasks[index],
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  Widget buildNoData() {
    return Center(
                  child: CardWidget(
                    padding: const EdgeInsets.all(32),
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_launch.png",
                        width: 80,
                      ),
                      MyText.build(
                        "Empty task!",
                        fontSize: 20,
                      ),
                      const SizedBox(height: 2,),
                      MyText.build("There is no task here yet.",
                          fontSize: 16, color: MyTheme.TEXT_SUBTITLE),
                    ],
                  )),
                );
  }
}
