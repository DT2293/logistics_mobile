import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/home_page.dart';
import 'package:logistic/services/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  // Controllers để lấy giá trị từ các ô nhập liệu
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fromHostController = TextEditingController();

  // Trạng thái tải
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
checkAutoLogin(); // Gọi tryAutoLogin khi trang được khởi tạo
  }



// static Future<bool> tryAutoLogin() async {
//   // Lấy token và thời gian hết hạn từ AuthService
//   final token = await AuthService.getAuthenticateToken();
//   final expired = await AuthService.getExpiredAuthenticateToken();
//   final refresh = await AuthService.getRefreshToken();

//   // Kiểm tra nếu không có token hoặc expired date
//   if (token == null || expired == null) {
//     print("❌ Không có token hoặc ngày hết hạn");
//     return false; // Không thể tự động đăng nhập
//   }

//   // Định dạng lại ngày hết hạn từ chuỗi không hợp lệ sang chuẩn ISO 8601
//   final formattedExpired = expired.substring(0, 4) + '-' + expired.substring(4, 6) + '-' + expired.substring(6, 8) + 'T' + expired.substring(8, 10) + ':' + expired.substring(10, 12) + ':' + expired.substring(12, 14);
  
//   final now = DateTime.now();
//   final expiredDate = DateTime.tryParse(formattedExpired);

//   if (expiredDate == null) {
//     print("❌ Ngày hết hạn không hợp lệ: $formattedExpired");
//     return false; // Không thể tiếp tục nếu ngày hết hạn không hợp lệ
//   }

//   if (now.isBefore(expiredDate)) {
//     print("✅ Token còn hạn, tiếp tục sử dụng");
//     return true; // Token còn hạn, tiếp tục sử dụng
//   }

//   // Nếu token đã hết hạn nhưng có refreshToken thì làm mới token
//   if (refresh != null) {
//     final result = await AuthService.refreshToken(refresh);
//     return result['success'] == true; // Trả về kết quả làm mới token
//   }

//   // Không còn cách nào -> auto login thất bại
//   print("❌ Token đã hết hạn và không có refreshToken để làm mới");
//   return false;
// }
void checkAutoLogin() async {
  final success = await tryAutoLogin();
  if (success) {
    final tokenData = await AuthService.getStoredKtLogisticsToken();
    if (tokenData != null) {
      // Để sau khi build xong UI mới push
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToHomePage(tokenData);
      });
    }
  } else {
    print('Cần đăng nhập lại');
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    // });
  }
}


  void _navigateToHomePage(KtLogisticsToken tokenData) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(token: tokenData)),
    );
  }

  Future<void> handleLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final fromHost = fromHostController.text.trim();

    // Kiểm tra các trường hợp thiếu thông tin
    if (username.isEmpty || password.isEmpty || fromHost.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    setState(() => isLoading = true); // Bắt đầu loading

    // Gọi API đăng nhập
    final result = await AuthService.login(
      username: username,
      password: password,
      fromHost: fromHost,
    );

    setState(() => isLoading = false); // Kết thúc loading

    if (result['success']) {
      // Nếu đăng nhập thành công
      final KtLogisticsToken tokenData = result['data']; // Lấy token từ kết quả

      // Lưu thông tin vào SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // Đánh dấu đã đăng nhập
      await prefs.setString(
        'authToken',
        tokenData.authenticateToken,
      ); // Lưu token
      await prefs.setString(
        'token_data',
        jsonEncode(result['data']),
      ); // Lưu toàn bộ token data nếu cần

      // Chuyển sang trang chính
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(token: tokenData)),
      );
    } else {
      // Nếu đăng nhập thất bại
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Đăng nhập thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ô nhập Username
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Tên đăng nhập',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Ô nhập Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Ô nhập FromHost
            TextField(
              controller: fromHostController,
              decoration: const InputDecoration(
                labelText: 'From Host',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Nút đăng nhập
            isLoading
                ? const CircularProgressIndicator() // Hiển thị loading khi đang xử lý
                : ElevatedButton(
                    onPressed: handleLogin,
                    child: const Text('Đăng nhập'),
                  ),
          ],
        ),
      ),
    );
  }
}
Future<bool> tryAutoLogin() async {
  final token = await AuthService.getAuthenticateToken();
  final expired = await AuthService.getExpiredAuthenticateToken();
  final refresh = await AuthService.getRefreshToken();

  if (token == null || expired == null) {
    print("❌ Không có token hoặc ngày hết hạn");
    return false;
  }

  final formattedExpired = expired.substring(0, 4) + '-' +
      expired.substring(4, 6) + '-' +
      expired.substring(6, 8) + 'T' +
      expired.substring(8, 10) + ':' +
      expired.substring(10, 12) + ':' +
      expired.substring(12, 14);

  final now = DateTime.now();
  final expiredDate = DateTime.tryParse(formattedExpired);

  if (expiredDate == null) {
    print("❌ Ngày hết hạn không hợp lệ: $formattedExpired");
    return false;
  }

  if (now.isBefore(expiredDate)) {
    print("✅ Token còn hạn, tiếp tục sử dụng");
    return true;
  }

  if (refresh != null) {
    final result = await AuthService.refreshToken(refresh);
    return result['success'] == true;
  }

  print("❌ Token đã hết hạn và không có refreshToken để làm mới");
  return false;
}
