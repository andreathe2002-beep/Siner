import '../models/task_model.dart';

class TaskService {
  static final List<TaskModel> _tasks = [
    TaskModel(
      id: 't1',
      projectId: 'p1',
      title: 'Recolección de muestras - Zona Norte',
      description: 'Colectar muestras biológicas en la zona norte del altiplano.',
      status: TaskStatus.inProgress,
      priority: TaskPriority.high,
      assigneeId: 'u3',
      dueDate: DateTime(2026, 10, 15),
      subtasks: ['Preparar equipos', 'Viaje a terreno', 'Recolección', 'Inventario inicial'],
      completedSubtasks: 2,
      createdAt: DateTime(2026, 8, 1),
    ),
    TaskModel(
      id: 't2',
      projectId: 'p1',
      title: 'Análisis taxonómico preliminar',
      description: 'Clasificar especies recolectadas en la primera fase.',
      status: TaskStatus.todo,
      priority: TaskPriority.medium,
      assigneeId: 'u4',
      dueDate: DateTime(2026, 11, 30),
      subtasks: ['Revisión bibliográfica', 'Identificación morfológica', 'Análisis genético'],
      completedSubtasks: 0,
      createdAt: DateTime(2026, 8, 5),
    ),
    TaskModel(
      id: 't3',
      projectId: 'p2',
      title: 'Etiquetado de dataset Cardiovida-v2',
      description: 'Revisar y etiquetar 1200 imágenes restantes.',
      status: TaskStatus.inProgress,
      priority: TaskPriority.urgent,
      assigneeId: 'u5',
      dueDate: DateTime(2026, 9, 28),
      subtasks: ['Lote A (400)', 'Lote B (400)', 'Lote C (400)'],
      completedSubtasks: 1,
      createdAt: DateTime(2026, 9, 1),
    ),
    TaskModel(
      id: 't4',
      projectId: 'p2',
      title: 'Entrenamiento modelo ResNet-152',
      description: 'Configurar y ejecutar entrenamiento con data augmentation.',
      status: TaskStatus.review,
      priority: TaskPriority.high,
      assigneeId: 'u3',
      dueDate: DateTime(2026, 10, 10),
      subtasks: ['Setup GPU', 'Config hiperparámetros', 'Entrenamiento', 'Métricas'],
      completedSubtasks: 3,
      createdAt: DateTime(2026, 9, 10),
    ),
    TaskModel(
      id: 't5',
      projectId: 'p2',
      title: 'Redacción artículo para journal',
      description: 'Preparar manuscrito para IEEE Transactions.',
      status: TaskStatus.todo,
      priority: TaskPriority.low,
      assigneeId: 'u1',
      dueDate: DateTime(2027, 1, 15),
      createdAt: DateTime(2026, 9, 15),
    ),
    TaskModel(
      id: 't6',
      projectId: 'p3',
      title: 'Levantamiento de información comunidades',
      description: 'Encuestas de consumo energético en 5 comunidades rurales.',
      status: TaskStatus.todo,
      priority: TaskPriority.medium,
      assigneeId: 'u4',
      dueDate: DateTime(2026, 12, 1),
      createdAt: DateTime(2026, 9, 1),
    ),
    TaskModel(
      id: 't7',
      projectId: 'p4',
      title: 'Digitalización de grabaciones',
      description: 'Digitalizar 80 cintas de audio de tradiciones orales.',
      status: TaskStatus.done,
      priority: TaskPriority.high,
      assigneeId: 'u5',
      dueDate: DateTime(2026, 7, 31),
      subtasks: ['Lote 1', 'Lote 2', 'Lote 3', 'Lote 4'],
      completedSubtasks: 4,
      createdAt: DateTime(2026, 3, 1),
    ),
    TaskModel(
      id: 't8',
      projectId: 'p1',
      title: 'Revisión bibliográfica sistematizada',
      description: 'Revisión sistemática de literatura sobre cambio climático andino.',
      status: TaskStatus.done,
      priority: TaskPriority.medium,
      assigneeId: 'u2',
      dueDate: DateTime(2026, 8, 31),
      createdAt: DateTime(2026, 5, 1),
    ),
  ];

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
