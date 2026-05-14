import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_tile.dart';

class CompletedTasksScreen extends GetView<TaskController> {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),
      body: Obx(() {
        final completedTasks = controller.tasks
            .where((t) => t.isCompleted)
            .toList();

        if (completedTasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'No completed tasks yet',
                  style: TextStyle(
                    color: AppColors.textSecondaryLight,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: completedTasks.length,
          itemBuilder: (context, index) {
            final task = completedTasks[index];
            return TaskTile(
              task: task,
              onChanged: (v) => controller.toggleTask(task.id, v ?? false),
              onDeleted: () => controller.deleteTask(task.id),
            );
          },
        );
      }),
    );
  }
}
