import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_tile.dart';

class DashboardScreen extends GetView<TaskController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Ready to conquer your day?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 24),
            _buildProgressCard(context),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Today'),
            const SizedBox(height: 12),
            Obx(
              () => _buildTaskList(
                controller.tasks
                    .where(
                      (t) =>
                          t.dueDate == null ||
                          t.dueDate!.day == DateTime.now().day,
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Upcoming'),
            const SizedBox(height: 12),
            Obx(
              () => _buildTaskList(
                controller.tasks
                    .where(
                      (t) =>
                          t.dueDate != null &&
                          t.dueDate!.isAfter(DateTime.now()),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addTask),
        child: const Icon(Icons.add),
      ).animate().scale(delay: 400.ms),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withAlpha(60),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Progress",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${controller.completedTasksCount} ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '/ ${controller.totalTasks}',
                  style: const TextStyle(color: Colors.white70, fontSize: 24),
                ),
              ],
            ),
            const Text(
              'Tasks completed',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: controller.progress,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _buildTaskList(List tasks) {
    if (tasks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'No tasks here',
            style: TextStyle(color: AppColors.textSecondaryLight),
          ),
        ),
      );
    }
    return Column(
      children: tasks
          .map(
            (task) => TaskTile(
              task: task,
              onChanged: (v) => controller.toggleTask(task.id, v ?? false),
              onDeleted: () => controller.deleteTask(task.id),
            ),
          )
          .toList(),
    );
  }
}
