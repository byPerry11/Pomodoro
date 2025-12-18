import 'package:injectable/injectable.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

@injectable
class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() {
    return repository.getTasks();
  }
}

@injectable
class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) {
    return repository.addTask(task);
  }
}

@injectable
class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) {
    return repository.updateTask(task);
  }
}

@injectable
class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(String taskId) {
    return repository.deleteTask(taskId);
  }
}
