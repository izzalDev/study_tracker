import 'package:flutter/material.dart';
import 'package:study_tracker/core/constants/app_colors.dart';
import 'package:study_tracker/core/constants/app_strings.dart';
import 'package:study_tracker/features/tasks/models/task_model.dart';
import 'package:study_tracker/features/tasks/widgets/task_card.dart';
import 'package:study_tracker/routes/app_routes.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late List<TaskModel> tasks;

  @override
  void initState() {
    super.initState();
    tasks = TaskModel.getDummyTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.myTasks)),
      body: tasks.isEmpty ? _buildEmptyState() : _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        tooltip: AppStrings.addTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.noTasks,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _buildDismissibleTaskCard(task, index);
      },
    );
  }

  Widget _buildDismissibleTaskCard(TaskModel task, int index) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: _buildDeleteBackground(),
      confirmDismiss: (direction) => _showDeleteConfirmation(task),
      onDismissed: (direction) => _deleteTask(index),
      child: InkWell(
        onTap: () => _navigateToDetail(task),
        borderRadius: BorderRadius.circular(12),
        child: TaskCard(task: task),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.delete, color: Colors.white, size: 32),
    );
  }

  Future<bool?> _showDeleteConfirmation(TaskModel task) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.deleteTask),
        content: const Text(AppStrings.deleteTaskConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.taskDeleted),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToDetail(TaskModel task) {
    Navigator.pushNamed(context, AppRoutes.taskDetail, arguments: task);
  }

  void _navigateToAddTask() {
    Navigator.pushNamed(context, AppRoutes.addTask);
  }
}
