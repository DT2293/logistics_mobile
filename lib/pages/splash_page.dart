import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/pages/home/home_page.dart';
import 'package:logistic/pages/login_page.dart';
import 'package:logistic/provider/notification_provider.dart';
import 'package:logistic/services/authservice.dart';
import 'package:logistic/models/ktlogistics_token.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  void _initApp() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final tokenData = await tryAutoLogin(); // trả về KtLogisticsToken? thay vì bool
    print('🔍 Auto login token: $tokenData');

    if (tokenData != null) {
      final userId = tokenData.userLogisticsInfosModels.oneUserLogisticsInfo.userId.toString();
    //  final signalR = ref.read(signalRServiceProvider); // lấy từ Riverpod

      try {
     //   await signalR.startConnection(userId);
        print('🔌 SignalR kết nối với userId: $userId');
      } catch (e) {
        print('❌ Không kết nối được SignalR: $e');
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(token: tokenData)),
        );
      });
      return;
    }

    // Nếu không login được thì chuyển về login
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
