// notification_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/notification_model.dart';
import 'package:logistic/services/notification_services.dart';




class NotificationNotifier extends StateNotifier<List<NotificationModel>> {
  final String userId;
  NotificationNotifier(this.userId) : super([]) {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final notifications = await NotificationService.fetchNotifications(userId);
    state = notifications;
  }

  void markAsRead(String id) {
    state = [
      for (final n in state)
        if (n.id == id)
          n.copyWith(status: true) // bạn cần thêm hàm `copyWith` trong model
        else
          n
    ];
  }

  int get unreadCount => state.where((n) => !n.status).length;
}

final notificationProvider = StateNotifierProvider.family<
    NotificationNotifier, List<NotificationModel>, String>((ref, userId) {
  return NotificationNotifier(userId);
});
