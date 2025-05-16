import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/notification_model.dart';
import 'package:logistic/services/notification_services.dart';
import 'package:logistic/services/signalRservice.dart';

class NotificationNotifier extends StateNotifier<List<NotificationModel>> {
  final Ref ref;
  final String userId;

  NotificationNotifier(this.ref, this.userId) : super([]) {
    fetchNotifications();
  }

  void addNotification(NotificationModel newNotif) {
    if (state.any((n) => n.id == newNotif.id)) {
      print('Notification already exists: ${newNotif.id}');
      // Nếu thông báo đã tồn tại thì không thêm
      return;
    }
   // print('Before add: ${state.map((e) => e.id).toList()}');
    state = [newNotif, ...state];
   // print('After add: ${state.map((e) => e.id).toList()}');
  }

  Future<void> fetchNotifications() async {
    final notifications = await NotificationService.fetchNotifications(userId);
    state = notifications;
  }

  void markAsRead(String id) {
    state = [
      for (final n in state)
        if (n.id == id) n.copyWith(status: true) else n,
    ];
  }
}
