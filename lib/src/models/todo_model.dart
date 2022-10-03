import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(1)
  final String id;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String note;

  @HiveField(4)
  final String date;

  @HiveField(5)
  final String time;

  @HiveField(6)
  bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.time,
    required this.isDone,
  });
}
