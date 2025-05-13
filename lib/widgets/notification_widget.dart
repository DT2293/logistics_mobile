import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/notifications/notifacation_page.dart';
import 'package:logistic/provider/notification_provider.dart';

Widget buildNotificationIcon(BuildContext context, WidgetRef ref, String userId, KtLogisticsToken token) {
  final notifications = ref.watch(notificationProvider(userId));
  final unreadCount = notifications.where((n) => !n.status).length;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationPage(token: token),
        ),
      ).then((_) {
        // Cập nhật lại khi quay về
        ref.read(notificationProvider(userId).notifier).fetchNotifications();
      });
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        const Icon(Icons.notifications, color: Colors.grey, size: 30),
        if (unreadCount > 0)
          Positioned(
            right: 0,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                '$unreadCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    ),
  );
}
