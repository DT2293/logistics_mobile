import 'package:flutter/material.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/widget/home_footer.dart';

class AppBottomBar extends StatelessWidget {
  final KtLogisticsToken token;

  const AppBottomBar({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return HomeFooter(token: token); // hoặc tùy chỉnh nội dung ở đây nếu muốn
  }
}
