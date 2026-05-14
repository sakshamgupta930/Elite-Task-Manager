import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/task_entity.dart';

class TaskTile extends StatelessWidget {
  final TaskEntity task;
  final Function(bool?) onChanged;
  final VoidCallback onDeleted;

  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDeleted(),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: task.isCompleted,
                  onChanged: onChanged,
                  shape: const CircleBorder(),
                  activeColor: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isCompleted
                            ? AppColors.textSecondaryLight
                            : null,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildPriorityTag(task.priority),
                        const SizedBox(width: 8),
                        _buildDateTimeInfo(context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildDateTimeInfo(BuildContext context) {
    if (task.dueDate == null && task.dueTime == null) {
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final taskDate = task.dueDate != null
        ? DateTime(task.dueDate!.year, task.dueDate!.month, task.dueDate!.day)
        : null;

    IconData icon = Icons.access_time;
    String text = '';

    if (taskDate == null) {
      // Only time is present
      text = task.dueTime ?? '';
    } else if (taskDate.isAtSameMomentAs(today)) {
      // Today
      text = task.dueTime ?? 'Today';
    } else if (taskDate.isAtSameMomentAs(tomorrow)) {
      // Tomorrow
      icon = Icons.calendar_today_outlined;
      text = 'Tomorrow';
    } else {
      // Other dates
      icon = Icons.calendar_today_outlined;
      text = DateFormat('MM/dd/yyyy').format(task.dueDate!);
    }

    if (text.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondaryLight),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondaryLight),
        ),
      ],
    );
  }

  Widget _buildPriorityTag(TaskPriority priority) {
    Color color;
    switch (priority) {
      case TaskPriority.low:
        color = AppColors.low;
        break;
      case TaskPriority.medium:
        color = AppColors.medium;
        break;
      case TaskPriority.high:
        color = AppColors.high;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        priority.name.capitalizeFirst!,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
