import '../models/message_model.dart';

class ChatService {
  static final List<MessageModel> _messages = [
    MessageModel(
      id: 'm1',
      projectId: 'p1',
      senderId: 'u1',
      senderName: 'Dra. Elena Vargas',
      content: 'Buenos días equipo, confirmo el viaje de campo para el 15 de octubre.',
      sentAt: DateTime(2026, 9, 18, 8, 30),
    ),
    MessageModel(
      id: 'm2',
      projectId: 'p1',
      senderId: 'u3',
      senderName: 'Dr. Tomás Riquelme',
      content: 'Perfecto, ya tengo listos los equipos de muestreo.',
      sentAt: DateTime(2026, 9, 18, 9, 15),
    ),
    MessageModel(
      id: 'm3',
      projectId: 'p1',
      senderId: 'u4',
      senderName: 'Ana Soto',
      content: 'Adjunto el protocolo actualizado con las nuevas zonas de estudio.',
      sentAt: DateTime(2026, 9, 18, 10, 0),
    ),
    MessageModel(
      id: 'm4',
      projectId: 'p1',
      senderId: 'u2',
      senderName: 'Dr. Martín Pérez',
      content: 'Revisé la literatura y hay 3 papers nuevos relevantes. Los comparto en documentos.',
      sentAt: DateTime(2026, 9, 19, 14, 30),
    ),
    MessageModel(
      id: 'm5',
      projectId: 'p1',
      senderId: 'u1',
      senderName: 'Dra. Elena Vargas',
      content: 'Excelente Martín. Los incluiremos en la revisión sistematizada.',
      sentAt: DateTime(2026, 9, 19, 15, 0),
      isEdited: true,
    ),
    MessageModel(
      id: 'm6',
      projectId: 'p2',
      senderId: 'u5',
      senderName: 'Carla Muñoz',
      content: 'Completé el Lote A del etiquetado. Avanzando con el Lote B.',
      sentAt: DateTime(2026, 9, 19, 11, 0),
    ),
    MessageModel(
      id: 'm7',
      projectId: 'p2',
      senderId: 'u3',
      senderName: 'Dr. Tomás Riquelme',
      content: 'El modelo ResNet alcanzó 94.2% de accuracy en validación. Subo las métricas.',
      sentAt: DateTime(2026, 9, 19, 16, 45),
    ),
    MessageModel(
      id: 'm8',
      projectId: 'p2',
      senderId: 'u1',
      senderName: 'Dra. Elena Vargas',
      content: '¡Gran avance! Preparemos el manuscrito para IEEE Transactions.',
      sentAt: DateTime(2026, 9, 20, 9, 0),
    ),
  ];

  List<MessageModel> getMessagesForProject(String projectId) {
    return _messages.where((m) => m.projectId == projectId).toList()
      ..sort((a, b) => a.sentAt.compareTo(b.sentAt));
  }

  List<MessageModel> getRecentMessages({int limit = 5}) {
    final sorted = List<MessageModel>.from(_messages)
      ..sort((a, b) => b.sentAt.compareTo(a.sentAt));
    return sorted.take(limit).toList();
  }

  void sendMessage(MessageModel message) {
    _messages.add(message);
  }

  int get unreadCount => _messages.length;
}
