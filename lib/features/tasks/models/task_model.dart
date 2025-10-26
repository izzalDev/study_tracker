class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  final TaskCategory category;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.category,
    this.isCompleted = false,
  });

  TaskStatus get status {
    if (isCompleted) return TaskStatus.completed;
    if (dueDate.isBefore(DateTime.now())) return TaskStatus.overdue;
    return TaskStatus.pending;
  }

  static List<TaskModel> getDummyTasks() {
    final now = DateTime.now();

    return [
      TaskModel(
        id: '1',
        title: 'Complete Math Assignment',
        description: 'Finish calculus homework chapter 5',
        dueDate: now.add(const Duration(days: 2)),
        priority: TaskPriority.high,
        category: TaskCategory.study,
        isCompleted: false,
      ),
      TaskModel(
        id: '2',
        title: 'Read History Chapter 3',
        description: 'Read about World War II and make notes',
        dueDate: now.add(const Duration(days: 5)),
        priority: TaskPriority.medium,
        category: TaskCategory.project,
        isCompleted: false,
      ),
      TaskModel(
        id: '3',
        title: 'Physics Lab Report',
        description: 'Write lab report for pendulum experiment',
        dueDate: now.subtract(const Duration(days: 1)),
        priority: TaskPriority.high,
        category: TaskCategory.personal,
        isCompleted: false,
      ),
      TaskModel(
        id: '4',
        title: 'English Essay Draft',
        description: 'First draft of argumentative essay',
        dueDate: now.add(const Duration(days: 7)),
        priority: TaskPriority.low,
        category: TaskCategory.assignment,
        isCompleted: false,
      ),
      TaskModel(
        id: '5',
        title: 'Chemistry Quiz Prep',
        description: 'Study organic chemistry for quiz',
        dueDate: now.subtract(const Duration(days: 3)),
        priority: TaskPriority.medium,
        category: TaskCategory.assignment,
        isCompleted: true,
      ),
    ];
  }
}

enum TaskPriority { low, medium, high }

enum TaskStatus { completed, pending, overdue }

enum TaskCategory {
  study('Study'),
  assignment('Assignment'),
  project('Project'),
  personal('Personal');

  final String label;
  const TaskCategory(this.label);
}
