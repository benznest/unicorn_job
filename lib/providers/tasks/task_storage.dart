import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task.dart';

class TaskStorage{

  static const String key = "tasks";

  static Future open() async {
    await Hive.openBox(key);
  }

  static List<Task> get(){
    var box = Hive.box(key);
    return box.values.map((d) => d as Task).toList().reversed.toList();
  }

  static add(Task task) async {
    var box = Hive.box(key);
    return await box.add(task);
  }
}