import '../models/notification_model.dart';

class NotificationService {
  static final List<NotificationModel> _notifications = [];

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
