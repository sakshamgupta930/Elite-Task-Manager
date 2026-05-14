import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/task_entity.dart';
import '../controllers/task_controller.dart';

class AddTaskScreen extends GetView<TaskController> {
  AddTaskScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            'Close',
            style: TextStyle(color: AppColors.textSecondaryLight),
          ),
        ),
        title: const Text('New Task'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.titleController,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  hintText: 'What needs to be done?',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black26),
                  errorStyle: TextStyle(fontSize: 12),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              _buildLabel(context, Icons.folder_open_outlined, 'Category'),
              const SizedBox(height: 12),
              Obx(
                () => Wrap(
                  spacing: 8,
                  children: TaskCategory.values.map((category) {
                    final isSelected =
                        controller.selectedCategory.value == category;
                    return ChoiceChip(
                      label: Text(category.name.capitalizeFirst!),
                      selected: isSelected,
                      onSelected: (val) =>
                          controller.selectedCategory.value = category,
                      selectedColor: AppColors.primaryBlue,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),
              _buildLabel(context, Icons.flag_outlined, 'Priority'),
              const SizedBox(height: 12),
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: TaskPriority.values.map((priority) {
                      final isSelected =
                          controller.selectedPriority.value == priority;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              controller.selectedPriority.value = priority,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.accentBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              priority.name.capitalizeFirst!,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.primaryBlue
                                    : AppColors.textSecondaryLight,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildLabel(context, Icons.calendar_today_outlined, 'Due Date'),
              const SizedBox(height: 12),
              FormField<DateTime?>(
                initialValue: controller.selectedDate.value,
                validator: (value) {
                  if (controller.selectedDate.value == null) {
                    return 'Please select a date';
                  }
                  return null;
                },
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => _buildInputTile(
                          text: controller.selectedDate.value == null
                              ? 'Select Date'
                              : DateFormat(
                                  'MM/dd/yyyy',
                                ).format(controller.selectedDate.value!),
                          icon: Icons.calendar_month,
                          hasError: state.hasError,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              controller.selectedDate.value = date;
                              state.didChange(date);
                            }
                          },
                        ),
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildLabel(context, Icons.access_time, 'Time'),
              const SizedBox(height: 12),
              FormField<String>(
                initialValue: controller.selectedTime.value,
                validator: (value) {
                  if (controller.selectedTime.value.isEmpty) {
                    return 'Please select a time';
                  }
                  return null;
                },
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => _buildInputTile(
                          text: controller.selectedTime.value.isEmpty
                              ? 'Select Time'
                              : controller.selectedTime.value,
                          icon: Icons.access_time,
                          hasError: state.hasError,
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null && context.mounted) {
                              final formattedTime = time.format(context);
                              controller.selectedTime.value = formattedTime;
                              state.didChange(formattedTime);
                            }
                          },
                        ),
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: AppColors.textSecondaryLight),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await controller.addTask();
                          if (success) {
                            Get.back();
                          }
                        }
                      },
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Save Task'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondaryLight),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.textSecondaryLight,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInputTile({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    bool hasError = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasError ? Colors.red : Colors.grey.shade200,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Icon(icon, size: 18, color: AppColors.textSecondaryLight),
          ],
        ),
      ),
    );
  }
}
