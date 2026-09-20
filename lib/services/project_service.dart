import '../models/project_model.dart';
import '../models/objective_model.dart';

class ProjectService {
  static final List<ProjectModel> _projects = [];
  static final List<ObjectiveModel> _objectives = [];

  List<ProjectModel> getAllProjects() => List.unmodifiable(_projects);

  ProjectModel? getProjectById(String id) {
    try {
      return _projects.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  List<ObjectiveModel> getObjectivesForProject(String projectId) {
    return _objectives.where((o) => o.projectId == projectId).toList();
  }

  List<ProjectModel> getProjectsByStatus(ProjectStatus status) {
    return _projects.where((p) => p.status == status).toList();
  }

  void addProject(ProjectModel project) {
    _projects.insert(0, project);
  }

  void updateProject(ProjectModel project) {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
    }
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    _objectives.removeWhere((o) => o.projectId == id);
  }

  int get totalProjects => _projects.length;

  int get activeProjects =>
      _projects.where((p) => p.status == ProjectStatus.active).length;

  double get totalBudget =>
      _projects.fold(0, (sum, p) => sum + p.budget);

  double get totalSpent =>
      _projects.fold(0, (sum, p) => sum + p.spent);

  double get averageProgress {
    if (_projects.isEmpty) return 0;
    return _projects.fold(0, (sum, p) => sum + p.progress) / _projects.length;
  }
}
