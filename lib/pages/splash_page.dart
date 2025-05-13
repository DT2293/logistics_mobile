import 'package:flutter/material.dart';
import 'package:logistic/pages/home/home_page.dart';
import 'package:logistic/pages/login_page.dart';
import 'package:logistic/services/authservice.dart';
import 'package:logistic/models/ktlogistics_token.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  void _initApp() async {
    await Future.delayed(const Duration(milliseconds: 1500)); // splash nhẹ
    final success = await tryAutoLogin();
    print('🔍 Auto login success: $success');

    if (success) {
      final tokenData = await AuthService.getStoredKtLogisticsToken();
      print('🔍 Token data: $tokenData');

      if (tokenData != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage(token: tokenData)),
          );
        });
        return;
      } else {
        print('⚠️ Token data null mặc dù token còn hạn');
      }
    }

    // Nếu không có token hoặc thất bại thì vào login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
