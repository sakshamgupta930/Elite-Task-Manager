import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'dashboard_screen.dart';
import 'completed_tasks_screen.dart';
import 'insights_screen.dart';
import 'support_screen.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Widget> screens = [
      DashboardScreen(),
      CompletedTasksScreen(),
      InsightsScreen(),
      SupportScreen(),
    ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: screens,
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.task_outlined),
              selectedIcon: Icon(Icons.task),
              label: 'Tasks',
            ),
            NavigationDestination(
              icon: Icon(Icons.check_circle_outline),
              selectedIcon: Icon(Icons.check_circle),
              label: 'Completed',
            ),
            NavigationDestination(
              icon: Icon(Icons.analytics_outlined),
              selectedIcon: Icon(Icons.analytics),
              label: 'Insights',
            ),
            NavigationDestination(
              icon: Icon(Icons.help_outline),
              selectedIcon: Icon(Icons.help),
              label: 'Support',
            ),
          ],
        ),
      ),
    );
  }
}
