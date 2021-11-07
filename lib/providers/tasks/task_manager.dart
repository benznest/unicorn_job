import 'package:unicorn_app_scheduler/providers/jobs/job.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task_storage.dart';

class TaskManager {
  static check() {
    DateTime now = DateTime.now();
    List<Task> listTasks = TaskStorage.get();
    for (Task task in listTasks) {
      if(!task.launched && task.dateTime.isBefore(now)){
        task.launched = true;
        task.save();
      }
    }
  }

  static createTask(Job job) {
    Task task = Task(jobId: job.id);
    task.title = job.title;
    task.dateTime = job.nextLaunchDateTime ?? DateTime.now();
    task.commands = job.commands;
    task.workingDirectory = job.workingDirectory;
    task.launched = false;
    task.number = 1;
    TaskStorage.add(task);
  }

  static delete(Job job) async {
    List<Task> listTasks = TaskStorage.get();
    for (Task task in listTasks) {
      if(task.jobId == job.id && !task.launched) {
        await task.delete();
      }
    }
  }
}
