// import 'package:flutter/material.dart';
// import 'package:logistic/models/ktlogistics_token.dart';
// import 'package:logistic/pages/home/home_page.dart';
// import 'package:logistic/pages/login_page.dart';
// import 'package:logistic/services/authservice.dart';

// class SplashPage extends StatefulWidget {
//   final KtLogisticsToken token; // Đảm bảo đây là KtLogisticsToken

//   const SplashPage({super.key, required this.token});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//     _checkAutoLogin();
//   }

//   Future<void> _checkAutoLogin() async {
//     await Future.delayed(const Duration(seconds: 2)); // hiệu ứng chờ

//     final isLoggedIn = await AuthService.tryAutoLogin();

//     if (!mounted) return;

//     if (isLoggedIn) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => HomePage(token: widget.token), // Truyền KtLogisticsToken vào HomePage
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const LoginPage(),
//         ),
//       );
//     }
//   }

//    @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(), // hiệu ứng chờ
//       ),
//     );
//   }

// }


 