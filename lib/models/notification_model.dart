class NotificationModel {
  final int id;
  final String userId;
  final DateTime timeIn;
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
    return NotificationModel(
      id: json['id'],
      userId: json['userId'],
      timeIn: DateTime.parse(json['timeIn']),
      message: json['message'],
      heading: json['heading'],
      status: json['status'],
    );
  }

   NotificationModel copyWith({
    int? id,
    String? userId,
    DateTime? timeIn,
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
}
