class LoginModel {
  final String uname;
  final String pass;
  final String fromHost;
  final String apiDate;
  final String hashValue; // Đổi tên tại đây

  LoginModel({
    required this.uname,
    required this.pass,
    required this.fromHost,
    required this.apiDate,
    required this.hashValue,
  });

  Map<String, dynamic> toJson() => {
        'Uname': uname,
        'Pass': pass,
        'FromHost': fromHost,
        'ApiDate': apiDate,
        'HashCode': hashValue, // key vẫn là HashCode như backend yêu cầu
      };
}
