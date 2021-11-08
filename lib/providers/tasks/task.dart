import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  Task({
    this.jobId,
    int? number,
    bool? launched,
    bool? skip,
  }) {
    id = DateTime.now().millisecondsSinceEpoch;
    this.number = number ?? 1;
    this.launched = launched ?? false;
    this.skip = skip ?? false;
  }

  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late DateTime dateTime;

  @HiveField(3)
  late String executable;

  @HiveField(4)
  late String arguments;

  @HiveField(5)
  late bool launched;

  @HiveField(6)
  late int number;

  @HiveField(7)
  int? jobId;

  @HiveField(8)
  bool? skip;
}
