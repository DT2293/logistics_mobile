import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:logistic/models/login_model.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Thêm package SharedPreferences

class AuthService {
  static const String baseUrl = 'https://licketoan.huetechcoop.com';

  static String computeSha256Hash(String rawData) {
    final bytes = utf8.encode(rawData);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    required String fromHost,
  }) async {
    final now = DateTime.now();
    final apiDate =
        "${now.year.toString().padLeft(4, '0')}"
        "${now.month.toString().padLeft(2, '0')}"
        "${now.day.toString().padLeft(2, '0')}"
        "${now.hour.toString().padLeft(2, '0')}"
        "${now.minute.toString().padLeft(2, '0')}"
        "${now.second.toString().padLeft(2, '0')}";

    final rawData = '$username|$password|$apiDate|$fromHost|0988';
    final hashCode = computeSha256Hash(rawData);

    final loginModel = LoginModel(
      uname: username,
      pass: password,
      fromHost: fromHost,
      apiDate: apiDate,
      hashValue: hashCode,
    );

    final url = Uri.parse('$baseUrl/apiweb/KeToanLic/DangNhap');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginModel.toJson()),
    );

    print('📥 RESPONSE BODY: ${response.body}');
    try {
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('📥 Parsed JSON: $responseData');

        if (responseData['messCode'] == 0 || responseData['messCode'] == 1) {
          final token = KtLogisticsToken.fromJson(responseData);
          token.userLogisticsInfosModels.lstFunctions.forEach((f) {
            print('🔧 Quyền có trong token: ${f.functionName}');
          });

          // Lưu token vào SharedPreferences
          // await _saveTokenToSharedPreferences(token.authenticateToken, token.userLogisticsInfosModels.listDepartmentFunctions);

          await _saveTokenToSharedPreferences(
            token.authenticateToken,
            token.userLogisticsInfosModels.listDepartmentFunctions,
            expiredAuthenticateToken: token.expiredAuthenticateToken,
            refreshToken: token.refreshToken,
            expiredRefreshToken: token.expiredRefreshToken,
          );

          return {'success': true, 'data': token};
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Đăng nhập thất bại',
            'data': responseData,
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Lỗi kết nối máy chủ (${response.statusCode})',
        };
      }
    } catch (e) {
      print('Error parsing response: $e');
      return {
        'success': false,
        'message': 'Lỗi khi phân tích dữ liệu đăng nhập',
        'error': e.toString(),
      };
    }
  }

  static Future<void> _saveTokenToSharedPreferences(
    String authenticateToken,
    List<DepartmentFunction> listDepartmentFunctions, {
    String? expiredAuthenticateToken,
    String? refreshToken,
    String? expiredRefreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Lưu authenticateToken
    await prefs.setString('authenticateToken', authenticateToken);
    print('📥 Saved authenticateToken: $authenticateToken');

    // Lưu thêm 3 token mới nếu có
    if (expiredAuthenticateToken != null) {
      await prefs.setString(
        'expiredAuthenticateToken',
        expiredAuthenticateToken,
      );
      print('📥 Saved expiredAuthenticateToken: $expiredAuthenticateToken');
    }

    if (refreshToken != null) {
      await prefs.setString('refreshToken', refreshToken);
      print('📥 Saved refreshToken: $refreshToken');
    }

    if (expiredRefreshToken != null) {
      await prefs.setString('expiredRefreshToken', expiredRefreshToken);
      print('📥 Saved expiredRefreshToken: $expiredRefreshToken');
    }

    // Lưu funcsTagActive
    final matchedFunction = listDepartmentFunctions.firstWhere(
      (item) => item.component?.toLowerCase() == "forward",
      orElse: () => DepartmentFunction(),
    );

    final funcsTagActive = matchedFunction.funcsTagActive ?? '';
    await prefs.setString('funcsTagActive', funcsTagActive);
    print('📥 Saved funcsTagActive: $funcsTagActive');
  }

  // static Future<String?> getAuthenticateToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('authenticateToken');
  // }

static Future<KtLogisticsToken?> getAuthenticateToken() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('token_data');
  if (jsonString == null) return null;
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  return KtLogisticsToken.fromJson(jsonMap);
}

  static Future<String?> getFuncsTagActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('funcsTagActive');
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  static Future<String?> getExpiredAuthenticateToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('expiredAuthenticateToken');
  }

  static Future<String?> getExpiredRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('expiredRefreshToken');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<Map<String, dynamic>> _refreshToken(String refreshToken) async {
    try {
      final url = Uri.parse('$baseUrl/apiweb/KeToanLic/RefreshToken');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['messCode'] == 0 || data['messCode'] == 1) {
          final token = KtLogisticsToken.fromJson(data);

          await _saveTokenToSharedPreferences(
            token.authenticateToken,
            token.userLogisticsInfosModels.listDepartmentFunctions,
            expiredAuthenticateToken: token.expiredAuthenticateToken,
            refreshToken: token.refreshToken,
            expiredRefreshToken: token.expiredRefreshToken,
          );

          return {'success': true, 'token': token.authenticateToken};
        }
      }

      return {'success': false, 'message': 'Làm mới token thất bại'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  static Future<bool> tryAutoLogin() async {
    final token = await getAuthenticateToken();
    final expired = await getExpiredAuthenticateToken();
    final refresh = await getRefreshToken();

    if (token == null || expired == null) return false;

    final now = DateTime.now();
    final expiredDate = DateTime.tryParse(expired);

    // Nếu token còn hạn thì dùng luôn
    if (expiredDate != null && now.isBefore(expiredDate)) {
      print("✅ Token còn hạn, tiếp tục sử dụng");
      return true;
    }

    // Nếu token hết hạn, nhưng có refreshToken -> thử làm mới
    if (refresh != null) {
      final result = await _refreshToken(refresh);
      return result['success'] == true;
    }

    // Không còn cách nào -> auto login thất bại
    return false;
  }
}



 // Phương thức lưu token và funcsTagActive vào SharedPreferences
  // Phương thức lưu token và funcsTagActive vào SharedPreferences
// static Future<void> _saveTokenToSharedPreferences(
//   String authenticateToken,
//   List<DepartmentFunction> listDepartmentFunctions,
// ) async {
//   final prefs = await SharedPreferences.getInstance();

//   // Lưu authenticateToken
//   await prefs.setString('authenticateToken', authenticateToken);
//   print('📥 Saved authenticateToken: $authenticateToken');
//   listDepartmentFunctions.forEach((d) {
//   print("🔍 Department Component: ${d.component} | funcsTagActive: ${d.funcsTagActive}");
// });

//   // Tìm item có component == "forward" (hoặc "forword" tùy theo dữ liệu)
//   final matchedFunction = listDepartmentFunctions.firstWhere(
//     (item) => item.component?.toLowerCase() == "forward",
//     orElse: () => DepartmentFunction(), // hoặc null nếu bạn dùng nullable class
//   );

//   final funcsTagActive = matchedFunction.funcsTagActive ?? '';

//   await prefs.setString('funcsTagActive', funcsTagActive);
//   print('📥 Saved funcsTagActive: $funcsTagActive');
  
// }
