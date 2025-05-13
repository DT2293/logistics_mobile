import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/models/notification_model.dart';
import 'package:logistic/provider/notification_provider.dart';
import 'package:logistic/services/notification_services.dart';

class NotificationPage extends ConsumerWidget {
  final KtLogisticsToken token;
  const NotificationPage({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId =token.userLogisticsInfosModels?.oneUserLogisticsInfo.userId ?? '';
    final notifications = ref.watch(notificationProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo')),
      body: notifications.isEmpty
          ? const Center(child: Text('Không có thông báo'))
          : ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final n = notifications[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: n.status
                          ? Colors.grey.shade300
                          : Colors.blue.shade200,
                      width: 1.0,
                    ),
                  ),
                  elevation: n.status ? 0 : 2,
                  color: n.status ? Colors.grey.shade100 : Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    leading: Icon(
                      n.status
                          ? Icons.mark_email_read
                          : Icons.mark_email_unread,
                      color: n.status ? Colors.green : Colors.red,
                    ),
                    title: Text(
                      n.heading,
                      style: TextStyle(
                        fontWeight: n.status
                            ? FontWeight.normal
                            : FontWeight.bold,
                        color: n.status ? Colors.grey : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      n.message,
                      style: TextStyle(
                        fontWeight: n.status
                            ? FontWeight.normal
                            : FontWeight.bold,
                        color: n.status ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat('dd/MM/yyyy')
                            .format(n.timeIn.toLocal())),
                        Text(DateFormat('HH:mm').format(n.timeIn.toLocal())),
                      ],
                    ),
                    onTap: () {
                      if (!n.status) {
                        ref
                            .read(notificationProvider(userId).notifier)
                            .markAsRead(n.id.toString());
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
