import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../../../core/constants/app_strings.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              task.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                // Due Date
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM dd, yyyy').format(task.dueDate),
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _getStatusLabel(task.status),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusLabel(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return AppStrings.statusCompleted;
      case TaskStatus.pending:
        return AppStrings.statusPending;
      case TaskStatus.overdue:
        return AppStrings.statusOverdue;
    }
  }
}
