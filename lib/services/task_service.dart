import '../models/task_model.dart';

class TaskService {
  static final List<TaskModel> _tasks = [];

  List<TaskModel> getAllTasks() => List.unmodifiable(_tasks);

  List<TaskModel> getTasksForProject(String projectId) {
    return _tasks.where((t) => t.projectId == projectId).toList();
  }

  List<TaskModel> getTasksByStatus(TaskStatus status) {
    return _tasks.where((t) => t.status == status).toList();
  }

  List<TaskModel> getTasksByAssignee(String userId) {
    return _tasks.where((t) => t.assigneeId == userId).toList();
  }

  List<TaskModel> getOverdueTasks() {
    return _tasks.where((t) => t.isOverdue).toList();
  }

  List<TaskModel> getUpcomingTasks({int days = 7}) {
    final limit = DateTime.now().add(Duration(days: days));
    return _tasks.where((t) {
      if (t.dueDate == null || t.status == TaskStatus.done) return false;
      return t.dueDate!.isBefore(limit);
    }).toList();
  }

  void addTask(TaskModel task) {
    _tasks.insert(0, task);
  }

  void updateTask(TaskModel task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }

  void updateTaskStatus(String taskId, TaskStatus status) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(status: status);
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
  }

  int get totalTasks => _tasks.length;

  int get completedTasks =>
      _tasks.where((t) => t.status == TaskStatus.done).length;

  int get overdueCount => getOverdueTasks().length;

  double get completionRate {
    if (_tasks.isEmpty) return 0;
    return completedTasks / _tasks.length * 100;
  }
}
