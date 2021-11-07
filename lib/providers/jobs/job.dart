import 'package:hive/hive.dart';
import 'package:unicorn_app_scheduler/providers/jobs/job_repetition.dart';

part 'job.g.dart';

@HiveType(typeId: 1)
class Job extends HiveObject {
  Job() {
    id = DateTime.now().millisecondsSinceEpoch;
  }

  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late int repetition;

  @HiveField(3)
  late DateTime dateTime;

  @HiveField(4)
  late String workingDirectory;

  @HiveField(5)
  late String commands;

  DateTime? nextLaunchDateTime({DateTime? base}) {
    if (repetition == JobRepetition.single.id) {
      return dateTime;
    }
    if (repetition == JobRepetition.daily.id) {
      int hr = dateTime.hour;
      int minute = dateTime.minute;
      DateTime now = base ?? DateTime.now();
      DateTime dt = DateTime(now.year, now.month, now.day, hr, minute);
      if (dt.isBefore(now)) {
        dt = dt.add(const Duration(days: 1));
      }
      return dt;
    }
    return null;
  }
}
