import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_tracker/core/constants/app_colors.dart';
import 'package:study_tracker/core/constants/app_strings.dart';
import 'package:study_tracker/features/tasks/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getStatusBorderColor(),
          width: task.status == TaskStatus.overdue ? 1.5 : 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Title + Priority Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: task.isCompleted
                          ? Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6)
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _buildPriorityBadge(context),
              ],
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            // Footer: Due Date + Status
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: _getStatusColor()),
                const SizedBox(width: 6),
                Text(
                  DateFormat('MMM dd, yyyy').format(task.dueDate),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                _buildStatusBadge(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(BuildContext context) {
    final (bgColor, textColor, label) = _getPriorityBadgeData();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: textColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final (bgColor, textColor, icon, label) = _getStatusBadgeData();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  (Color bgColor, Color textColor, String label) _getPriorityBadgeData() {
    switch (task.priority) {
      case TaskPriority.high:
        return (
          AppColors.priorityHighLight,
          AppColors.priorityHigh,
          AppStrings.priorityHigh,
        );
      case TaskPriority.medium:
        return (
          AppColors.priorityMediumLight,
          AppColors.priorityMedium,
          AppStrings.priorityMedium,
        );
      case TaskPriority.low:
        return (
          AppColors.priorityLowLight,
          AppColors.priorityLow,
          AppStrings.priorityLow,
        );
    }
  }

  (Color bgColor, Color textColor, IconData icon, String label)
  _getStatusBadgeData() {
    switch (task.status) {
      case TaskStatus.completed:
        return (
          AppColors.statusCompletedLight,
          AppColors.statusCompleted,
          Icons.check_circle,
          AppStrings.statusCompleted,
        );
      case TaskStatus.pending:
        return (
          AppColors.statusPendingLight,
          AppColors.statusPending,
          Icons.schedule,
          AppStrings.statusPending,
        );
      case TaskStatus.overdue:
        return (
          AppColors.statusOverdueLight,
          AppColors.statusOverdue,
          Icons.warning,
          AppStrings.statusOverdue,
        );
    }
  }

  Color _getStatusColor() {
    switch (task.status) {
      case TaskStatus.completed:
        return AppColors.statusCompleted;
      case TaskStatus.pending:
        return AppColors.statusPending;
      case TaskStatus.overdue:
        return AppColors.statusOverdue;
    }
  }

  Color _getStatusBorderColor() {
    switch (task.status) {
      case TaskStatus.completed:
        return AppColors.statusCompleted.withValues(alpha: 0.3);
      case TaskStatus.pending:
        return AppColors.outline.withValues(alpha: 0.2);
      case TaskStatus.overdue:
        return AppColors.statusOverdue.withValues(alpha: 0.5);
    }
  }
}
