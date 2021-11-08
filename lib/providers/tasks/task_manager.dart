import 'package:unicorn_app_scheduler/providers/jobs/job.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_repetition.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_storage.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task_storage.dart';
import 'package:unicorn_app_scheduler/commands/my_command.dart';

class TaskManager {
  static check() {
    DateTime now = DateTime.now();
    List<Task> listTasks = TaskStorage.get();
    for (Task task in listTasks) {
      if (!task.launched && task.dateTime.isBefore(now)) {
        launch(task);
      }
    }
  }

  static void launch(Task task, {bool skip = false}) {
    if (!skip) {
      MyCommand.run(
          executable: task.executable, arguments: task.arguments);
      task.launched = true;
    }

    task.skip = skip;
    task.save();

    Job? job = JobStorage.find(task.jobId);
    if (job != null) {
      if (job.repetition == JobRepetition.daily.id) {
        createTask(job,
            number: task.number + 1,
            base: task.dateTime.add(const Duration(days: 1)));
      }
    }
  }

  static createTask(Job job, {int? number, DateTime? base}) {
    Task task = Task(jobId: job.id);
    task.title = job.title;
    task.dateTime = job.nextLaunchDateTime(base: base) ?? DateTime.now();
    task.executable = job.executable;
    task.arguments = job.arguments;
    task.launched = false;
    task.number = number ?? 1;
    TaskStorage.add(task);
  }

  static delete(Job job) async {
    List<Task> listTasks = TaskStorage.get();
    for (Task task in listTasks) {
      if (task.jobId == job.id && !task.launched) {
        await task.delete();
      }
    }
  }
}
