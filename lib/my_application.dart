
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_storage.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task.dart';
import 'package:unicorn_app_scheduler/providers/tasks/task_storage.dart';

class MyApplication{

  static PackageInfo? packageInfo;

  static init() async {
    // init Hive instance.
    await Hive.initFlutter();

    // init Job Hive.
    Hive.registerAdapter(JobAdapter());
    await JobStorage.open();

    // init Task Hive.
    Hive.registerAdapter(TaskAdapter());
    await TaskStorage.open();

    // init package info.
    packageInfo = await PackageInfo.fromPlatform();
  }
}