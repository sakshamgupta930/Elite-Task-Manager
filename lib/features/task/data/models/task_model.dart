import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.isCompleted,
    super.priority,
    super.category,
    super.dueDate,
    super.dueTime,
    super.completedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == (json['priority'] ?? 'medium'),
        orElse: () => TaskPriority.medium,
      ),
      category: TaskCategory.values.firstWhere(
        (e) => e.name == (json['category'] ?? 'personal'),
        orElse: () => TaskCategory.personal,
      ),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      dueTime: json['dueTime'],
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'priority': priority.name,
      'category': category.name,
      'dueDate': dueDate?.toIso8601String(),
      'dueTime': dueTime,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      isCompleted: entity.isCompleted,
      priority: entity.priority,
      category: entity.category,
      dueDate: entity.dueDate,
      dueTime: entity.dueTime,
      completedAt: entity.completedAt,
    );
  }
}
