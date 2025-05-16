import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/models/notification_model.dart';
import 'package:logistic/provider/notification_provider.dart';
import 'package:logistic/services/signalRservice.dart';
class NotificationPage extends ConsumerStatefulWidget {
  final KtLogisticsToken token;
  const NotificationPage({super.key, required this.token});
  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  late final String userId;
  late final SignalRService signalR;

  @override
  void initState() {
    super.initState();
    userId = widget.token.userLogisticsInfosModels?.oneUserLogisticsInfo.userId ?? '';
  }
  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationProvider(userId));

    final grouped = <String, List<NotificationModel>>{};
    for (final n in notifications) {
      final date = DateFormat('dd/MM/yyyy').format(n.parsedTimeIn ?? DateTime.now());
      grouped.putIfAbsent(date, () => []).add(n);
    }

    final sortedDates = grouped.keys.toList()
      ..sort((a, b) => DateFormat('dd/MM/yyyy').parse(b).compareTo(DateFormat('dd/MM/yyyy').parse(a)));

    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo')),
      body: notifications.isEmpty
          ? const Center(child: Text('Không có thông báo'))
          : ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                final date = sortedDates[index];
                final items = grouped[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.grey[200],
                      child: Text(
                        date,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...items.map((n) => ListTile(
                          leading: Icon(
                            n.status ? Icons.mark_email_read : Icons.mark_email_unread,
                            color: n.status ? Colors.green : Colors.red,
                          ),
                          title: Text(n.heading),
                          subtitle: Text(n.message),
                          trailing: Text(
                            n.parsedTimeIn != null
                                ? DateFormat('HH:mm').format(n.parsedTimeIn!)
                                : '??:??',
                          ),
                          onTap: () {
                            if (!n.status) {
                              ref
                                  .read(notificationProvider(userId).notifier)
                                  .markAsRead(n.id.toString());
                            }
                          },
                        )),
                  ],
                );
              },
            ),
    );
  }
}
