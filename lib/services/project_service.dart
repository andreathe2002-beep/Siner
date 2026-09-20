import '../models/project_model.dart';
import '../models/objective_model.dart';

class ProjectService {
  static final List<ProjectModel> _projects = [
    ProjectModel(
      id: 'p1',
      title: 'Cambio Climático y Biodiversidad Andina',
      description:
          'Estudio del impacto del cambio climático en la biodiversidad de ecosistemas andinos, con foco en especies endémicas.',
      area: 'Ecología',
      status: ProjectStatus.active,
      leadId: 'u1',
      memberIds: ['u1', 'u2', 'u3', 'u4'],
      startDate: DateTime(2026, 3, 1),
      endDate: DateTime(2027, 12, 31),
      budget: 250000,
      spent: 87500,
      progress: 35,
      tags: ['Clima', 'Biodiversidad', 'Andes'],
      createdAt: DateTime(2026, 2, 15),
    ),
    ProjectModel(
      id: 'p2',
      title: 'Inteligencia Artificial para Diagnóstico Médico',
      description:
          'Desarrollo de modelos de IA para diagnóstico temprano de enfermedades cardiovasculares.',
      area: 'Informática Médica',
      status: ProjectStatus.active,
      leadId: 'u1',
      memberIds: ['u1', 'u3', 'u5'],
      startDate: DateTime(2026, 1, 15),
      endDate: DateTime(2027, 6, 30),
      budget: 180000,
      spent: 120000,
      progress: 60,
      tags: ['IA', 'Salud', 'Diagnóstico'],
      createdAt: DateTime(2026, 1, 5),
    ),
    ProjectModel(
      id: 'p3',
      title: 'Energías Renovables en Zonas Rurales',
      description:
          'Análisis de viabilidad técnica y económica de sistemas energéticos descentralizados.',
      area: 'Ingeniería Energética',
      status: ProjectStatus.planning,
      leadId: 'u2',
      memberIds: ['u2', 'u4'],
      startDate: DateTime(2026, 10, 1),
      endDate: DateTime(2028, 3, 31),
      budget: 320000,
      spent: 15000,
      progress: 8,
      tags: ['Energía', 'Rural', 'Sostenibilidad'],
      createdAt: DateTime(2026, 8, 20),
    ),
    ProjectModel(
      id: 'p4',
      title: 'Patrimonio Cultural Inmaterial',
      description:
          'Documentación y preservación digital de tradiciones orales en comunidades originarias.',
      area: 'Antropología',
      status: ProjectStatus.onHold,
      leadId: 'u2',
      memberIds: ['u2', 'u3', 'u5'],
      startDate: DateTime(2025, 9, 1),
      endDate: DateTime(2026, 12, 31),
      budget: 95000,
      spent: 71000,
      progress: 72,
      tags: ['Cultura', 'Patrimonio', 'Digital'],
      createdAt: DateTime(2025, 8, 10),
    ),
    ProjectModel(
      id: 'p5',
      title: 'Nanomateriales para Tratamiento de Agua',
      description:
          'Síntesis y caracterización de nanomateriales para remoción de contaminantes en agua potable.',
      area: 'Nanotecnología',
      status: ProjectStatus.completed,
      leadId: 'u1',
      memberIds: ['u1', 'u4'],
      startDate: DateTime(2024, 6, 1),
      endDate: DateTime(2026, 5, 31),
      budget: 140000,
      spent: 138000,
      progress: 100,
      tags: ['Nanotecnología', 'Agua', 'Materiales'],
      createdAt: DateTime(2024, 5, 15),
    ),
  ];

  static final List<ObjectiveModel> _objectives = [
    ObjectiveModel(
      id: 'o1',
      projectId: 'p1',
      title: 'Inventario de especies endémicas',
      description: 'Catalogar todas las especies endémicas en 3 zonas de estudio.',
      status: ObjectiveStatus.inProgress,
      targetDate: DateTime(2027, 6, 30),
      milestones: ['Seleccionar zonas', 'Recolección campo', 'Análisis taxonómico', 'Publicación'],
      completedMilestones: 2,
      createdAt: DateTime(2026, 2, 20),
    ),
    ObjectiveModel(
      id: 'o2',
      projectId: 'p1',
      title: 'Modelo predictivo de impacto climático',
      description: 'Desarrollar un modelo de predicción del impacto en 10 años.',
      status: ObjectiveStatus.notStarted,
      targetDate: DateTime(2027, 9, 30),
      milestones: ['Recopilar datos climáticos', 'Entrenar modelo', 'Validar resultados'],
      completedMilestones: 0,
      createdAt: DateTime(2026, 2, 20),
    ),
    ObjectiveModel(
      id: 'o3',
      projectId: 'p2',
      title: 'Dataset de imágenes médicas',
      description: 'Compilar y etiquetar un dataset de 5000 imágenes.',
      status: ObjectiveStatus.achieved,
      targetDate: DateTime(2026, 6, 30),
      milestones: ['Adquisición', 'Etiquetado', 'Validación'],
      completedMilestones: 3,
      createdAt: DateTime(2026, 1, 10),
    ),
    ObjectiveModel(
      id: 'o4',
      projectId: 'p2',
      title: 'Modelo de deep learning',
      description: 'Entrenar modelo CNN para clasificación de patologías.',
      status: ObjectiveStatus.inProgress,
      targetDate: DateTime(2027, 3, 31),
      milestones: ['Arquitectura', 'Entrenamiento', 'Optimización', 'Evaluación clínica'],
      completedMilestones: 2,
      createdAt: DateTime(2026, 1, 10),
    ),
  ];

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
