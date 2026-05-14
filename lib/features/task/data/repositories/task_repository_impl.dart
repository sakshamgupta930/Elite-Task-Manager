import 'package:get_storage/get_storage.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final GetStorage _storage;

  TaskRepositoryImpl(this._storage);

  @override
  Future<List<TaskEntity>> getTasks() async {
    final List<dynamic>? storedTasks = _storage.read(Constants.taskKey);
    if (storedTasks != null) {
      return storedTasks
          .map<TaskEntity>((taskJson) => TaskModel.fromJson(taskJson))
          .toList();
    }
    return [];
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final tasks = await getTasks();
    tasks.insert(0, task);
    await _saveTasks(tasks);
  }

  @override
  Future<void> toggleTask(TaskEntity task) async {
    final tasks = await getTasks();
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      await _saveTasks(tasks);
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final tasks = await getTasks();
    tasks.removeWhere((t) => t.id == taskId);
    await _saveTasks(tasks);
  }

  Future<void> _saveTasks(List<TaskEntity> tasks) async {
    final jsonTasks = tasks
        .map((task) => TaskModel.fromEntity(task).toJson())
        .toList();
    await _storage.write(Constants.taskKey, jsonTasks);
  }
}
