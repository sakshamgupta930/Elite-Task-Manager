import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class SupportScreen extends GetView<MainController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Guide & Support')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.help_center_outlined,
                      size: 64,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Elite Task Manager Guide',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Learn how to master your productivity',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildGuideSection(
              context,
              icon: Icons.add_circle_outline,
              title: 'Creating Tasks',
              description:
                  'Tap the "+" button on the Dashboard to create a task. You must provide a title, due date, and due time. You can also assign a category and priority.',
            ),
            _buildGuideSection(
              context,
              icon: Icons.check_circle_outline,
              title: 'Completing Tasks',
              description:
                  'Tap the circular checkbox on any task tile to mark it as complete. Completed tasks move to the "Completed" tab and update your Insights.',
            ),
            _buildGuideSection(
              context,
              icon: Icons.delete_outline,
              title: 'Deleting Tasks',
              description:
                  'Swipe any task tile from right to left to delete it permanently. This action cannot be undone.',
            ),
            _buildGuideSection(
              context,
              icon: Icons.analytics_outlined,
              title: 'Tracking Progress',
              description:
                  'Visit the "Insights" tab to see your overall progress, daily goal completion, and weekly activity trends.',
            ),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Common Questions'),
            _buildSettingTile(
              context,
              icon: Icons.category_outlined,
              title: 'Categories',
              subtitle:
                  'Use Work, Personal, Health, or Finance to group your tasks.',
            ),
            _buildSettingTile(
              context,
              icon: Icons.flag_outlined,
              title: 'Priorities',
              subtitle:
                  'High, Medium, and Low priorities help you focus on what matters.',
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.mail_outline),
                label: const Text('Contact Support'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: colorScheme.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.onSurface),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
