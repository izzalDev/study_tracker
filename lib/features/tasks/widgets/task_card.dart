import 'package:flutter/material.dart';
import 'package:study_tracker/features/tasks/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onCheckChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onCheckChanged,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getPriorityColor(), width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 8),
              _buildDescription(),
              const SizedBox(height: 12),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Priority indicator
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: _getPriorityColor(),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),

        // Task title
        Expanded(
          child: Text(
            task.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),

        // Checkbox
        Checkbox(
          value: task.isCompleted,
          onChanged: onCheckChanged != null
              ? (value) => onCheckChanged!(value ?? false)
              : null,
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      task.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey[600], fontSize: 14),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        // Category chip
        _CategoryChip(category: task.category),
        const SizedBox(width: 8),

        // Due date
        Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          _formatDate(task.dueDate),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),

        const Spacer(),

        // Action buttons
        if (onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: onEdit,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        if (onDelete != null) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete, size: 18, color: Colors.red),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ],
    );
  }

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 0) return 'Overdue';
    return '${difference}d left';
  }
}

// Helper widget: Category chip
class _CategoryChip extends StatelessWidget {
  final TaskCategory category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getCategoryColor().withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.name,
        style: TextStyle(
          fontSize: 12,
          color: _getCategoryColor(),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (category) {
      case TaskCategory.study:
        return Colors.blue;
      case TaskCategory.assignment:
        return Colors.purple;
      case TaskCategory.project:
        return Colors.orange;
      case TaskCategory.personal:
        return Colors.green;
    }
  }
}
