import 'dart:async';

import 'package:signalr_core/signalr_core.dart';

import 'package:signalr_core/signalr_core.dart';

class SignalRService {
  late HubConnection _connection;

  // Stream controller để gửi thông báo đến UI
  final StreamController<String> _notificationStreamController = StreamController<String>.broadcast();
  Stream<String> get notificationStream => _notificationStreamController.stream;

  Future<void> startConnection(String userId) async {
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

    _connection.on("ReceiveNotification", _receiveNotification);

    try {
      await _connection.start();
      print("✅ SignalR Connected với userId: $userId");
      await _connection.invoke('ConnectWithUserId', args: [userId]);
    } catch (e) {
      print("❌ SignalR Connection Error: $e");
      rethrow;
    }
  }

  // Xử lý nhận thông báo
  void _receiveNotification(List<Object?>? notification) {
    print("📨 Nhận thông báo mới: $notification");
    try {
      if (notification != null) {
        // Bạn có thể tùy chỉnh dữ liệu thông báo nếu cần
        String heading = notification[0] as String;
        String content = notification[1] as String;

        // Gửi thông báo đến UI qua stream
        _notificationStreamController.sink.add('New Notification: $heading - $content');
      }
    } catch (error) {
      print("Lỗi khi xử lý thông báo: $error");
    }
  }

  // Dừng kết nối SignalR
  Future<void> stopConnection() async {
    await _connection.stop();
  }

  bool get isConnected => _connection.state == HubConnectionState.connected;

  // Hủy stream khi không cần sử dụng nữa
  void dispose() {
    _notificationStreamController.close();
  }
}
