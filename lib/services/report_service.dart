import '../models/report_model.dart';

class ReportService {
  static final List<ReportModel> _reports = [
    ReportModel(
      id: 'r1',
      projectId: 'p1',
      title: 'Informe Trimestral Q3 2026',
      summary:
          'Se completó la fase de recolección en la Zona Norte y se avanzó en la revisión bibliográfica.',
      authorId: 'u1',
      authorName: 'Dra. Elena Vargas',
      progressBefore: 20,
      progressAfter: 35,
      highlights: [
        'Inventario preliminar de 47 especies en Zona Norte',
        'Protocolo de muestreo actualizado a v2.1',
        'Revisión sistemática completada al 100%',
      ],
      challenges: [
        'Retraso por condiciones climáticas en acceso a terreno',
        'Disponibilidad limitada de equipos de secuenciación genética',
      ],
      nextSteps: [
        'Iniciar muestreo Zona Sur en octubre',
        'Solicitar tiempo de secuenciación para noviembre',
        'Preparar presentación para congreso ANDIS 2026',
      ],
      periodStart: DateTime(2026, 7, 1),
      periodEnd: DateTime(2026, 9, 30),
      createdAt: DateTime(2026, 9, 30),
    ),
    ReportModel(
      id: 'r2',
      projectId: 'p2',
      title: 'Informe de Avance - Fase 2',
      summary:
          'Se completó el dataset y se entrenaron dos arquitecturas de modelos con resultados prometedores.',
      authorId: 'u1',
      authorName: 'Dra. Elena Vargas',
      progressBefore: 40,
      progressAfter: 60,
      highlights: [
        'Dataset Cardiovida v2 con 5200 imágenes etiquetadas',
        'ResNet-152 alcanzó 94.2% de accuracy en validación',
        'Presentación aceptada en congreso AMIA 2026',
      ],
      challenges: [
        'Necesidad de más datos de clases minoritarias',
        'Tiempo de entrenamiento superior al estimado',
      ],
      nextSteps: [
        'Data augmentation para clases minoritarias',
        'Evaluación clínica preliminar con cardiólogos',
        'Redacción de manuscrito para IEEE Transactions',
      ],
      periodStart: DateTime(2026, 6, 1),
      periodEnd: DateTime(2026, 9, 30),
      createdAt: DateTime(2026, 9, 25),
    ),
    ReportModel(
      id: 'r3',
      projectId: 'p4',
      title: 'Informe Anual 2025-2026',
      summary:
          'Avance significativo en la digitalización de patrimonio cultural inmaterial, con 80 grabaciones procesadas.',
      authorId: 'u2',
      authorName: 'Dr. Martín Pérez',
      progressBefore: 50,
      progressAfter: 72,
      highlights: [
        'Digitalización completa de 80 cintas de audio',
        'Catálogo preliminar con 120 entradas catalogadas',
        'Colaboración establecida con 3 comunidades originarias',
      ],
      challenges: [
        'Proyecto puesto en pausa por recorte de financiamiento',
        'Necesidad de equipo de conservación preventiva',
      ],
      nextSteps: [
        'Gestionar fondos complementarios',
        'Reanudar trabajo de campo al restablecerse fondos',
        'Preparar exposición digital interactiva',
      ],
      periodStart: DateTime(2025, 9, 1),
      periodEnd: DateTime(2026, 8, 31),
      createdAt: DateTime(2026, 9, 5),
    ),
    ReportModel(
      id: 'r4',
      projectId: 'p5',
      title: 'Informe Final - Nanomateriales para Agua',
      summary:
          'Proyecto completado con éxito. Se desarrollaron 3 nanomateriales con eficiencia superior al 95%.',
      authorId: 'u1',
      authorName: 'Dra. Elena Vargas',
      progressBefore: 90,
      progressAfter: 100,
      highlights: [
        '3 nanomateriales sintetizados y caracterizados',
        'Eficiencia de remoción de contaminantes >95%',
        'Tesis doctoral defendida y aprobada',
        '2 artículos publicados en revistas Q1',
      ],
      challenges: [
        'Escalado a nivel piloto requiere inversión adicional',
      ],
      nextSteps: [
        'Buscar financiamiento para fase piloto',
        'Transferencia tecnológica a empresa interesada',
      ],
      periodStart: DateTime(2024, 6, 1),
      periodEnd: DateTime(2026, 5, 31),
      createdAt: DateTime(2026, 6, 10),
    ),
  ];

  List<ReportModel> getAllReports() {
    final sorted = List<ReportModel>.from(_reports)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  List<ReportModel> getReportsForProject(String projectId) {
    return _reports.where((r) => r.projectId == projectId).toList();
  }

  void addReport(ReportModel report) {
    _reports.insert(0, report);
  }

  void deleteReport(String id) {
    _reports.removeWhere((r) => r.id == id);
  }

  int get totalReports => _reports.length;
}
