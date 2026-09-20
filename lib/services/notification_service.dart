import '../models/notification_model.dart';

class NotificationService {
  static final List<NotificationModel> _notifications = [
    NotificationModel(
      id: 'n1',
      type: NotificationType.taskAssigned,
      title: 'Nueva tarea asignada',
      body: 'Se te asignó "Recolección de muestras - Zona Norte" en Cambio Climático Andino.',
      projectId: 'p1',
      createdAt: DateTime(2026, 9, 19, 10, 0),
    ),
    NotificationModel(
      id: 'n2',
      type: NotificationType.deadlineReminder,
      title: 'Fecha límite próxima',
      body: 'La tarea "Etiquetado dataset Cardiovida-v2" vence en 8 días.',
      projectId: 'p2',
      createdAt: DateTime(2026, 9, 19, 8, 0),
    ),
    NotificationModel(
      id: 'n3',
      type: NotificationType.documentShared,
      title: 'Documento compartido',
      body: 'Ana Soto compartió "Protocolo de muestreo andino v2.pdf".',
      projectId: 'p1',
      createdAt: DateTime(2026, 9, 18, 10, 5),
    ),
    NotificationModel(
      id: 'n4',
      type: NotificationType.messageReceived,
      title: 'Nuevo mensaje en el chat',
      body: 'Dra. Elena Vargas: "Preparemos el manuscrito para IEEE..."',
      projectId: 'p2',
      createdAt: DateTime(2026, 9, 20, 9, 1),
    ),
    NotificationModel(
      id: 'n5',
      type: NotificationType.projectUpdate,
      title: 'Proyecto actualizado',
      body: 'El proyecto "IA para Diagnóstico Médico" alcanzó 60% de progreso.',
      projectId: 'p2',
      createdAt: DateTime(2026, 9, 17, 16, 0),
    ),
    NotificationModel(
      id: 'n6',
      type: NotificationType.mention,
      title: 'Fuiste mencionado',
      body: 'Dr. Martín Pérez te mencionó en el chat de Cambio Climático Andino.',
      projectId: 'p1',
      createdAt: DateTime(2026, 9, 19, 14, 35),
    ),
    NotificationModel(
      id: 'n7',
      type: NotificationType.taskAssigned,
      title: 'Tarea en revisión',
      body: 'La tarea "Entrenamiento modelo ResNet-152" pasó a revisión.',
      projectId: 'p2',
      createdAt: DateTime(2026, 9, 18, 17, 0),
      isRead: true,
    ),
  ];

  List<NotificationModel> getAllNotifications() {
    final sorted = List<NotificationModel>.from(_notifications)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  List<NotificationModel> getUnreadNotifications() {
    return getAllNotifications().where((n) => !n.isRead).toList();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  void markAllAsRead() {
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;
}
