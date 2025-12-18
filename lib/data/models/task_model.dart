import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  String? description;

  @Index()
  bool isCompleted = false;

  @Index()
  late DateTime createdAt;

  DateTime? completedAt;

  @enumerated
  late TaskUrgency urgency;
}

enum TaskUrgency { urgent, normal, canWait }
