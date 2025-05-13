import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logistic/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const String baseUrl = 'https://logistics.huetechcoop.com/api/Forwar';

  static Future<List<NotificationModel>> fetchNotifications(String userId) async {
    final prefs = await SharedPreferences.getInstance();
      String? authenticateToken = prefs.getString('authenticateToken');
        String? funcsTagActive = prefs.getString('funcsTagActive');

    final url = Uri.parse('$baseUrl/ListNotification?userId=$userId');
    final response = await http.get(
      url,
      headers: {
          'Accept': 'application/json',
          'AuthenticateToken': authenticateToken ?? '',
          'FuncsTagActive': funcsTagActive ?? '', 
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData.containsKey('items')) {
        final List items = jsonData['items'];
        return items.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        throw Exception('Không tìm thấy danh sách thông báo');
      }
    } else {
      throw Exception('Lỗi kết nối server: ${response.statusCode}');
    }
  }

  static Future<void> markNotificationAsRead(String notificationId) async {
    final prefs = await SharedPreferences.getInstance();
      String? authenticateToken = prefs.getString('authenticateToken');
        String? funcsTagActive = prefs.getString('funcsTagActive');

    final url = Uri.parse('$baseUrl/MarkNotificationAsRead?notificationId=$notificationId');
    final response = await http.post(
      url,
      headers: {
          'Accept': 'application/json',
          'AuthenticateToken': authenticateToken ?? '',
          'FuncsTagActive': funcsTagActive ?? '', 
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Lỗi khi đánh dấu thông báo là đã đọc: ${response.statusCode}');
    }
  }

}