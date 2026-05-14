import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../../domain/usecases/toggle_task_usecase.dart';

class TaskController extends GetxController {
  final GetTasksUseCase _getTasksUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final ToggleTaskUseCase _toggleTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskController(
    this._getTasksUseCase,
    this._addTaskUseCase,
    this._toggleTaskUseCase,
    this._deleteTaskUseCase,
  );

  final tasks = <TaskEntity>[].obs;

  // New Task form state
  final titleController = TextEditingController();
  final Rx<TaskPriority> selectedPriority = TaskPriority.medium.obs;
  final Rx<TaskCategory> selectedCategory = TaskCategory.personal.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final loadedTasks = await _getTasksUseCase();
    tasks.assignAll(loadedTasks);
  }

  Future<bool> addTask() async {
    if (titleController.text.trim().isEmpty ||
        selectedDate.value == null ||
        selectedTime.value.isEmpty) {
      return false;
    }

    final newTask = TaskEntity(
      id: const Uuid().v4(),
      title: titleController.text.trim(),
      isCompleted: false,
      priority: selectedPriority.value,
      category: selectedCategory.value,
      dueDate: selectedDate.value,
      dueTime: selectedTime.value,
    );

    await _addTaskUseCase(newTask);
    tasks.insert(0, newTask);

    // Reset form
    titleController.clear();
    selectedPriority.value = TaskPriority.medium;
    selectedCategory.value = TaskCategory.personal;
    selectedDate.value = null;
    selectedTime.value = '';

    return true;
  }

  Future<void> toggleTask(String id, bool isCompleted) async {
    final index = tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      final updatedTask = tasks[index].copyWith(
        isCompleted: isCompleted,
        completedAt: isCompleted ? DateTime.now() : null,
      );
      await _toggleTaskUseCase(updatedTask);
      tasks[index] = updatedTask;
    }
  }

  Future<void> deleteTask(String id) async {
    await _deleteTaskUseCase(id);
    tasks.removeWhere((t) => t.id == id);
  }

  // Insights Data
  int get totalTasks => tasks.length;
  int get completedTasksCount => tasks.where((t) => t.isCompleted).length;
  double get progress =>
      totalTasks == 0 ? 0.0 : completedTasksCount / totalTasks;

  List<double> get weeklyActivity {
    final activity = List.generate(7, (index) => 0.0);
    final now = DateTime.now();
    for (var i = 0; i < 7; i++) {
      final day = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i));
      final count = tasks.where((t) {
        if (!t.isCompleted || t.completedAt == null) return false;
        return t.completedAt!.year == day.year &&
            t.completedAt!.month == day.month &&
            t.completedAt!.day == day.day;
      }).length;
      activity[6 - i] = count.toDouble();
    }
    return activity;
  }

  double get dailyGoalProgress {
    final today = DateTime.now();
    final todayTasks = tasks
        .where(
          (t) =>
              t.dueDate != null &&
              t.dueDate!.year == today.year &&
              t.dueDate!.month == today.month &&
              t.dueDate!.day == today.day,
        )
        .toList();
    if (todayTasks.isEmpty) return 0.0;
    final completedToday = todayTasks.where((t) => t.isCompleted).length;
    return completedToday / todayTasks.length;
  }

  String get todayStatusText {
    final today = DateTime.now();
    final todayTasks = tasks
        .where(
          (t) =>
              t.dueDate != null &&
              t.dueDate!.year == today.year &&
              t.dueDate!.month == today.month &&
              t.dueDate!.day == today.day,
        )
        .toList();
    final completedToday = todayTasks.where((t) => t.isCompleted).length;
    return '$completedToday of ${todayTasks.length} tasks completed';
  }
}
