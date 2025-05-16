import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/home_page.dart';
import 'package:logistic/pages/login_page.dart';
import 'package:logistic/pages/notifications/notifacation_page.dart';

import 'package:logistic/services/authservice.dart';
import 'package:logistic/services/signalRservice.dart';

class HomeFooter extends ConsumerWidget {
  final KtLogisticsToken token;

  const HomeFooter({super.key, required this.token});

  void _logout(BuildContext context) async {
    await AuthService.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId =
        token.userLogisticsInfosModels?.oneUserLogisticsInfo.userId ?? '';
    final notifications = ref.watch(notificationProvider(userId));
    final unreadCount =
        notifications.where((n) => n.status == false).length;

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(token: token)),
              );
            },
            child: const Icon(Icons.home, color: Colors.blueAccent),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationPage(token: token)),
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications, color: Colors.grey),
                if (unreadCount > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Center(
                        child: Text(
                          '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _logout(context),
            child: const Icon(Icons.logout, color: Colors.red),
          ),
          const Icon(Icons.settings, color: Colors.grey),
        ],
      ),
    );
  }
}
