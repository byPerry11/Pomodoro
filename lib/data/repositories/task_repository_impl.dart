import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import '../../domain/entities/task.dart' as domain;
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart' as data;

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final Isar _isar;

  TaskRepositoryImpl(this._isar);

  @override
  Future<List<domain.Task>> getTasks() async {
    final taskModels =
        await _isar.collection<data.TaskModel>().where().findAll();

    // Sort: newest first
    taskModels.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return taskModels.map((model) => _toDomain(model)).toList();
  }

  @override
  Future<void> addTask(domain.Task task) async {
    final model = _toData(task);
    await _isar.writeTxn(() async {
      await _isar.collection<data.TaskModel>().put(model);
    });
  }

  @override
  Future<void> updateTask(domain.Task task) async {
    final model = _toData(task);
    await _isar.writeTxn(() async {
      await _isar.collection<data.TaskModel>().put(model);
    });
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final id = int.tryParse(taskId);
    if (id != null) {
      await _isar.writeTxn(() async {
        await _isar.collection<data.TaskModel>().delete(id);
      });
    }
  }

  // Mappers (Kept same logic)

  domain.Task _toDomain(data.TaskModel model) {
    return domain.Task(
      id: model.id.toString(),
      title: model.title,
      description: model.description,
      isCompleted: model.isCompleted,
      createdAt: model.createdAt,
      completedAt: model.completedAt,
      urgency: _mapUrgencyToDomain(model.urgency),
    );
  }

  data.TaskModel _toData(domain.Task task) {
    int? id = int.tryParse(task.id);

    final model = data.TaskModel()
      ..title = task.title
      ..description = task.description
      ..isCompleted = task.isCompleted
      ..createdAt = task.createdAt
      ..completedAt = task.completedAt
      ..urgency = _mapUrgencyToData(task.urgency);

    if (id != null) {
      model.id = id;
    }

    return model;
  }

  domain.TaskUrgency _mapUrgencyToDomain(data.TaskUrgency enumData) {
    switch (enumData) {
      case data.TaskUrgency.urgent:
        return domain.TaskUrgency.urgent;
      case data.TaskUrgency.normal:
        return domain.TaskUrgency.normal;
      case data.TaskUrgency.canWait:
        return domain.TaskUrgency.canWait;
    }
  }

  data.TaskUrgency _mapUrgencyToData(domain.TaskUrgency enumDomain) {
    switch (enumDomain) {
      case domain.TaskUrgency.urgent:
        return data.TaskUrgency.urgent;
      case domain.TaskUrgency.normal:
        return data.TaskUrgency.normal;
      case domain.TaskUrgency.canWait:
        return data.TaskUrgency.canWait;
    }
  }
}
