import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../models/project_model.dart';
import '../../services/project_service.dart';
import '../../services/task_service.dart';
import '../../utils/constants.dart';
import '../../widgets/project_card.dart';
import '../../widgets/empty_state.dart';
import '../app_scaffold.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _projectService = ProjectService();
  final _taskService = TaskService();
  String _searchQuery = '';
  ProjectStatus? _filterStatus;

  List<ProjectModel> get _filteredProjects {
    var projects = _projectService.getAllProjects();
    if (_filterStatus != null) {
      projects = projects.where((p) => p.status == _filterStatus).toList();
    }
    if (_searchQuery.isNotEmpty) {
      projects = projects.where((p) {
        return p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (p.area?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      }).toList();
    }
    return projects;
  }

  @override
  Widget build(BuildContext context) {
    final projects = _filteredProjects;

    return AppScaffold(
      title: 'Proyectos',
      currentIndex: 1,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createProject),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar proyectos...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: AppDimens.spaceMd),
            // Status filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Todos', null),
                  const SizedBox(width: AppDimens.spaceSm),
                  _buildFilterChip('Activos', ProjectStatus.active),
                  const SizedBox(width: AppDimens.spaceSm),
                  _buildFilterChip('Planificación', ProjectStatus.planning),
                  const SizedBox(width: AppDimens.spaceSm),
                  _buildFilterChip('En Pausa', ProjectStatus.onHold),
                  const SizedBox(width: AppDimens.spaceSm),
                  _buildFilterChip('Completados', ProjectStatus.completed),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.spaceLg),
            // Results count
            Text(
              '${projects.length} proyecto${projects.length == 1 ? '' : 's'}',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.spaceMd),
            // Projects grid
            if (projects.isEmpty)
              const EmptyState(
                icon: Icons.folder_off,
                title: 'Sin proyectos',
                message: 'No se encontraron proyectos con los filtros actuales.',
                actionLabel: 'Crear Proyecto',
              )
            else
              LayoutBuilder(builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
                final spacing = AppDimens.spaceMd;
                final itemWidth =
                    (constraints.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: projects.map((p) {
                    return SizedBox(
                      width: itemWidth,
                      child: Dismissible(
                        key: Key(p.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(AppDimens.radiusL),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (_) async {
                          return await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Eliminar proyecto'),
                              content: Text(
                                '¿Seguro que quieres eliminar "${p.title}"? '
                                'Se borrarán también sus tareas y objetivos.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  style: TextButton.styleFrom(foregroundColor: AppColors.error),
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            ),
                          );
                        },
                        onDismissed: (_) {
                          setState(() => _projectService.deleteProject(p.id));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Proyecto "${p.title}" eliminado'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        },
                        child: ProjectCard(
                          project: p,
                          memberCount: p.memberIds.length,
                          taskCount: _taskService.getTasksForProject(p.id).length,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.projectWorkspace,
                            arguments: p.id,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, ProjectStatus? status) {
    final isSelected = _filterStatus == status;
    return GestureDetector(
      onTap: () => setState(() => _filterStatus = status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
