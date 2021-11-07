import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  Task({required this.jobId, int? number, bool? launched}) {
    id = DateTime.now().millisecondsSinceEpoch;
    this.number = number ?? 1;
    this.launched = launched ?? false;
  }

  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late DateTime dateTime;

  @HiveField(3)
  late String workingDirectory;

  @HiveField(4)
  late String commands;

  @HiveField(5)
  late bool launched;

  @HiveField(6)
  late int number;

  @HiveField(7)
  late int? jobId;
}
