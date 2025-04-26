import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogisticsServices {
  static const String baseUrl = 'https://logistics.huetechcoop.com/api/forwar';

  // Hàm kiểm tra quyền Forward trong JWT
 // Hàm kiểm tra quyền Forward trong JWT


Future<bool> checkPermission(String authenticateToken, String funcsTagActive) async {
  try {
    // Lấy dữ liệu từ SharedPreferences (hoặc nơi lưu trữ khác) 
    final prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('authenticateToken');
    String? storedFuncsTagActive = prefs.getString('funcsTagActive');

    // Kiểm tra nếu không có dữ liệu
    if (storedToken == null || storedFuncsTagActive == null) {
      print('Không có thông tin token hoặc funcsTagActive');
      return false;
    }

    // So sánh authenticateToken và funcsTagActive với dữ liệu đã lưu
    if (authenticateToken == storedToken && funcsTagActive == storedFuncsTagActive) {
      print('✅ Có quyền Forward với funcsTagActive hợp lệ');
      return true;
    }

    print('Không có quyền Forward hoặc funcsTagActive không hợp lệ');
    return false;
  } catch (e) {
    print('Lỗi khi kiểm tra quyền: $e');
    return false;
  }
}

  // Hàm gọi GET API chung
  Future<Map<String, dynamic>?> getApiData({
    required String path,
    required String authenticateToken,
    required String funcsTagActive,
  }) async {
    // Kiểm tra quyền "Forward" và funcsTagActive
  

    // Tạo URL đầy đủ
    final url = Uri.parse('$baseUrl/$path');

    try {
      final response = await http.get(
        url, // Thêm Uri.parse() để đảm bảo URL đúng
        headers: {
          'Accept': 'application/json',
          'AuthenticateToken': authenticateToken,
          'FuncsTagActive': funcsTagActive,  // Sử dụng funcsTagActive từ SharedPreferences
        },
      );

      if (response.statusCode == 200) {
      //  print('✅ Dữ liệu từ $path: ${response.body}');
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 401) {
        print('❌ Lỗi 401: Token không hợp lệ hoặc hết hạn');
        return null;
      } else {
        print('❌ Lỗi ${response.statusCode}: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Lỗi khi gọi API $path: $e');
      return null;
    }
  }

  // Hàm cụ thể gọi API từng module
  Future<Map<String, dynamic>?> seaFclExport({
    required String authenticateToken,
    required String funcsTagActive,
  }) {
    return getApiData(
      path: 'listseafclexport',
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
    );
  }


   Future<Map<String, dynamic>?> sealclExport({
    required String authenticateToken,
    required String funcsTagActive,
  }) {
    return getApiData(
      path: 'listsealclexport',
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
    );
  }


   Future<Map<String, dynamic>?> sealclImport({
    required String authenticateToken,
    required String funcsTagActive,
  }) {
    return getApiData(
      path: 'listsealclimport',
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
    );
  }

   Future<Map<String, dynamic>?> seafclImport({
    required String authenticateToken,
    required String funcsTagActive,
  }) {
    return getApiData(
      path: 'listseafclimport',
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
    );
  }

    Future<Map<String, dynamic>?> airExport({
    required String authenticateToken,
    required String funcsTagActive,
  }) {
    return getApiData(
      path: 'listairExport',
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
    );
  }

  Future<Map<String, dynamic>?> airImport({
    required String authenticateToken,
    required String funcsTagActive,
  }) {
    return getApiData(
      path: 'listairImport',
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
    );
  }

}
