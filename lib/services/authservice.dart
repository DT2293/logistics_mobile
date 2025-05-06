import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:logistic/models/login_model.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://licketoan.huetechcoop.com';

  static String computeSha256Hash(String rawData) {
    final bytes = utf8.encode(rawData);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Đăng nhập
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    required String fromHost,
  }) async {
    try {
      final loginModel = _prepareLoginModel(username, password, fromHost);
      final response = await _sendLoginRequest(loginModel);
      return await _handleLoginResponse(response);
    } catch (e) {
      print('Error during login: $e');
      return {'success': false, 'message': 'Lỗi khi đăng nhập', 'error': e.toString()};
    }
  }

  // Chuẩn bị dữ liệu đăng nhập
  static LoginModel _prepareLoginModel(String username, String password, String fromHost) {
    final now = DateTime.now();
    final apiDate = _generateApiDate(now);
    final hashCode = computeSha256Hash('$username|$password|$apiDate|$fromHost|0988');
    return LoginModel(uname: username, pass: password, fromHost: fromHost, apiDate: apiDate, hashValue: hashCode);
  }

  // Tạo định dạng thời gian cho apiDate
  static String _generateApiDate(DateTime now) {
    return "${now.year.toString().padLeft(4, '0')}"
           "${now.month.toString().padLeft(2, '0')}"
           "${now.day.toString().padLeft(2, '0')}"
           "${now.hour.toString().padLeft(2, '0')}"
           "${now.minute.toString().padLeft(2, '0')}"
           "${now.second.toString().padLeft(2, '0')}";
  }

  // Gửi yêu cầu đăng nhập
  static Future<http.Response> _sendLoginRequest(LoginModel loginModel) async {
    final url = Uri.parse('$baseUrl/apiweb/KeToanLic/DangNhap');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginModel.toJson()),
    );
  }

  // Xử lý phản hồi đăng nhập
  static Future<Map<String, dynamic>> _handleLoginResponse(http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['messCode'] == 0 || responseData['messCode'] == 1) {
        final token = KtLogisticsToken.fromJson(responseData);
        await _saveTokenToSharedPreferences(token);
        return {'success': true, 'data': token};
      } else {
        return {'success': false, 'message': responseData['message'] ?? 'Đăng nhập thất bại'};
      }
    } else {
      return {'success': false, 'message': 'Lỗi kết nối máy chủ (${response.statusCode})'};
    }
  }

  // Lưu token vào SharedPreferences
  static Future<void> _saveTokenToSharedPreferences(KtLogisticsToken token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authenticateToken', token.authenticateToken);
    await prefs.setString('expiredAuthenticateToken', token.expiredAuthenticateToken ?? '');
    await prefs.setString('refreshToken', token.refreshToken ?? '');
    await prefs.setString('expiredRefreshToken', token.expiredRefreshToken ?? '');

    final funcsTagActive = _getFuncsTagActiveFromToken(token.userLogisticsInfosModels.listDepartmentFunctions);
    await prefs.setString('funcsTagActive', funcsTagActive);
  }

  // Lấy funcsTagActive từ token
  static String _getFuncsTagActiveFromToken(List<DepartmentFunction> listDepartmentFunctions) {
    final matchedFunction = listDepartmentFunctions.firstWhere(
      (item) => item.component?.toLowerCase() == "forward", 
      orElse: () => DepartmentFunction()
    );
    return matchedFunction.funcsTagActive ?? '';
  }

  // Kiểm tra và tự động đăng nhập
  static Future<bool> tryAutoLogin() async {
    final token = await getAuthenticateToken();
    final expired = await getExpiredAuthenticateToken();
    final refresh = await getRefreshToken();

    if (token == null || expired == null) return false;

    final now = DateTime.now();
    final expiredDate = DateTime.tryParse(expired);

    if (expiredDate != null && now.isBefore(expiredDate)) {
      print("✅ Token còn hạn, tiếp tục sử dụng");
      return true;
    }

    if (refresh != null) {
      final result = await refreshToken(refresh);
      return result['success'] == true;
    }

    return false;
  }

  // Lấy token từ SharedPreferences
  static Future<KtLogisticsToken?> getAuthenticateToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('token_data');
    if (jsonString == null) return null;
    return KtLogisticsToken.fromJson(json.decode(jsonString));
  }

  static Future<String?> getFuncsTagActive() async => await _getSharedPrefValue('funcsTagActive');
  static Future<String?> getRefreshToken() async => await _getSharedPrefValue('refreshToken');
  static Future<String?> getExpiredAuthenticateToken() async => await _getSharedPrefValue('expiredAuthenticateToken');
  static Future<String?> getExpiredRefreshToken() async => await _getSharedPrefValue('expiredRefreshToken');

  // Lấy giá trị từ SharedPreferences
  static Future<String?> _getSharedPrefValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Đăng xuất
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Làm mới token
  static Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    try {
      final url = Uri.parse('$baseUrl/apiweb/KeToanLic/RefreshLogin');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['messCode'] == 0 || data['messCode'] == 1) {
          final token = KtLogisticsToken.fromJson(data);
          await _saveTokenToSharedPreferences(token);
          return {'success': true, 'token': token.authenticateToken};
        }
      }
      return {'success': false, 'message': 'Làm mới token thất bại'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }


 static Future<KtLogisticsToken?> getStoredKtLogisticsToken() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonStr = prefs.getString('token_data');
//  print('📦 Đọc từ SharedPreferences: $jsonStr');

  if (jsonStr == null) return null;

  try {
    final json = jsonDecode(jsonStr);
    return KtLogisticsToken.fromJson(json);
  } catch (e) {
    print('❌ Lỗi khi decode token_data: $e');
    return null;
  }
}


}
