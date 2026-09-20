import '../models/message_model.dart';

class ChatService {
  static final List<MessageModel> _messages = [];

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
