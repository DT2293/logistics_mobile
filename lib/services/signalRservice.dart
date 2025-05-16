import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/notification_model.dart';
import 'package:logistic/provider/notification_provider.dart';

import 'package:signalr_core/signalr_core.dart';



class SignalRService {
  final Ref ref;
  final String userId;
  late HubConnection _connection;

  SignalRService(this.ref, this.userId);

  Future<void> startConnection() async {
    _connection = HubConnectionBuilder()
      .withUrl(
        'https://logistics.huetechcoop.com/notificationUserHub',
        HttpConnectionOptions(
          transport: HttpTransportType.webSockets,
          skipNegotiation: true,
        ),
      )
      .withAutomaticReconnect()
      .build();

    // _connection.on("ReceiveNotification", (notification) {
    //   if (notification != null && notification.isNotEmpty) {
    //     final firstData = notification.first;
    //     final mapData = Map<String, dynamic>.from(firstData as Map);
    //     final newNotif = NotificationModel.fromJson(mapData);

    //     // Cập nhật provider
    //     ref.read(notificationProvider(userId).notifier).addNotification(newNotif);
    //   }
    // });

    _connection.on("ReceiveNotification", (notification) {
  if (notification != null && notification.isNotEmpty) {
    final firstData = notification.first;
    final mapData = Map<String, dynamic>.from(firstData as Map);
    final newNotif = NotificationModel.fromJson(mapData);

    Future.microtask(() {
      ref.read(notificationProvider(userId).notifier).addNotification(newNotif);
    });
  }
});


    try {
      await _connection.start();
      await _connection.invoke('ConnectWithUserId', args: [userId]);
      print('✅ SignalR Connected userId: $userId');
    } catch (e) {
      print('❌ SignalR Connection Error: $e');
    }
  }

  Future<void> stopConnection() async {
    await _connection.stop();
    print('🛑 SignalR disconnected');
  }
}
final signalRServiceProvider = Provider.family<SignalRService, String>((ref, userId) {
  final signalR = SignalRService(ref, userId);
  signalR.startConnection();
  ref.onDispose(() {
    signalR.stopConnection();
  });
  return signalR;
});

final notificationProvider = StateNotifierProvider.family<NotificationNotifier, List<NotificationModel>, String>(
  (ref, userId) {
    // Lấy SignalRService để đảm bảo kết nối
    ref.read(signalRServiceProvider(userId));
    return NotificationNotifier(ref, userId);
  },
);
