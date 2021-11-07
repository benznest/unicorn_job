import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job.dart';

class JobStorage{

  static const String key = "jobs";

  static Future open() async {
    await Hive.openBox(key);
  }

  static List<Job> get(){
    var box = Hive.box(key);
    return box.values.map((d) => d as Job).toList().reversed.toList();
  }

  static add(Job job){
    var box = Hive.box(key);
    return box.add(job);
  }
}