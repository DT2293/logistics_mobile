import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/home_page.dart';
import 'package:logistic/services/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Hàm xử lý đăng nhập
Future<void> handleLogin() async {
  final username = usernameController.text.trim();
  final password = passwordController.text.trim();
  final fromHost = fromHostController.text.trim();

  if (username.isEmpty || password.isEmpty || fromHost.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
    );
    return;
  }

  setState(() => isLoading = true); // Bắt đầu loading

  final result = await AuthService.login(
    username: username,
    password: password,
    fromHost: fromHost,
  );

  setState(() => isLoading = false); // Kết thúc loading

  if (result['success']) {
   // Trong phương thức handleLogin:
  final KtLogisticsToken tokenData = result['data']; // Lấy token
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);  // Đánh dấu đã đăng nhập
  await prefs.setString('authToken', tokenData.authenticateToken);  // Lưu token

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(token: tokenData),
    ),
  );


  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'] ?? 'Đăng nhập thất bại')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
      ),
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



