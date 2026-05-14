import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/task_controller.dart';

class InsightsScreen extends GetView<TaskController> {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Insights',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Your productivity over time.',
                style: TextStyle(color: AppColors.textSecondaryLight),
              ),
              const SizedBox(height: 24),
              _buildSummaryCard(context),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildGoalCard(context, 'Daily Goals')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildWeeklyCard(context, 'Weekly')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overall Progress',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${(controller.progress * 100).toInt()}%',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: controller.progress,
              backgroundColor: AppColors.accentBlue,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryBlue,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${controller.completedTasksCount} of ${controller.totalTasks} tasks done',
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textSecondaryLight,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }

  Widget _buildGoalCard(BuildContext context, String title) {
    final progress = controller.dailyGoalProgress;
    return Container(
      height: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: AppColors.accentBlue,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryBlue,
                      ),
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            controller.todayStatusText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyCard(BuildContext context, String title) {
    final activity = controller.weeklyActivity;
    final maxActivity = activity.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: activity.map((val) => _bar(val, maxActivity)).toList(),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Last 7 Days',
            style: TextStyle(fontSize: 10, color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }

  Widget _bar(double value, double max) {
    final height = max == 0 ? 4.0 : (value / max) * 40.0 + 4.0;
    return Container(
      width: 8,
      height: height,
      decoration: BoxDecoration(
        color: value > 0 ? AppColors.primaryBlue : AppColors.accentBlue,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
