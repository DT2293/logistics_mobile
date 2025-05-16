import 'package:intl/intl.dart';

class NotificationModel {
  final int id;
  final String userId;
  final String timeIn;       // ISO8601 string như "2025-05-15T11:03:58.303"
  final String message;
  final String heading;
  final bool status;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.timeIn,
    required this.message,
    required this.heading,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final timeInStr = json['timeIn'] ?? '';  // lấy timeIn thay vì timestamp

    return NotificationModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      userId: json['userId'] ?? '',
      heading: json['heading'] ?? '',
      message: json['message'] ?? json['content'] ?? '',
      timeIn: timeInStr,
      status: (json['status'] is bool) 
          ? json['status'] 
          : (json['status']?.toString().toLowerCase() == 'true'),
    );
  }

  NotificationModel copyWith({
    int? id,
    String? userId,
    String? timeIn,
    String? message,
    String? heading,
    bool? status,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timeIn: timeIn ?? this.timeIn,
      message: message ?? this.message,
      heading: heading ?? this.heading,
      status: status ?? this.status,
    );
  }

  // Chuyển chuỗi ISO 8601 thành DateTime
DateTime? get parsedTimeIn {
  try {
    final raw = timeIn.trim();
    if (raw.isEmpty) return null;

    // Nếu là ISO 8601 chuẩn thì parse trực tiếp
    try {
      return DateTime.parse(raw);
    } catch (_) {}

    // Nếu không phải ISO, xử lý định dạng như "16:18 PM"
    final cleaned = raw.replaceAll(RegExp(r'\s*PM$', caseSensitive: false), '');

    final now = DateTime.now();
    final parts = cleaned.split(':');
    if (parts.length == 2) {
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;
      return DateTime(now.year, now.month, now.day, hour, minute);
    }
  } catch (e) {
    print("❌ Lỗi chuyển đổi timeIn: $e");
    print(" - giá trị timeIn: \"$timeIn\"");
  }
  return null;
}

}