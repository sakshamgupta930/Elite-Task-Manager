enum TaskPriority { low, medium, high }

enum TaskCategory { work, personal, health, finance }

class TaskEntity {
  final String id;
  final String title;
  final bool isCompleted;
  final TaskPriority priority;
  final TaskCategory category;
  final DateTime? dueDate;
  final String? dueTime;
  final DateTime? completedAt;

  TaskEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
    this.priority = TaskPriority.medium,
    this.category = TaskCategory.personal,
    this.dueDate,
    this.dueTime,
    this.completedAt,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    TaskPriority? priority,
    TaskCategory? category,
    DateTime? dueDate,
    String? dueTime,
    DateTime? completedAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
