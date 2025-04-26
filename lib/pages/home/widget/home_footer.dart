import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/home_page.dart';
import 'package:logistic/pages/login_page.dart';
import 'package:logistic/services/authservice.dart';

class HomeFooter extends StatelessWidget {
   final KtLogisticsToken token; // Thêm token vào constructor

  const HomeFooter({super.key, required this.token});


  void _logout(BuildContext context) async {
    await AuthService.logout(); // Xóa token lưu trong SharedPreferences

    // Chuyển về màn hình Login
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false, // Xóa toàn bộ lịch sử navigation
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              // Khi nhấn vào icon home, dẫn tới HomePage với token
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(token: token)),
              );
            },
            child: const Icon(Icons.home, color: Colors.blueAccent),
          ),
          const Icon(Icons.settings, color: Colors.grey),
          GestureDetector(
            onTap: () => _logout(context),
            child: const Icon(Icons.logout, color: Colors.red),
          ),
          
        ],
      ),
    );
  }
}
