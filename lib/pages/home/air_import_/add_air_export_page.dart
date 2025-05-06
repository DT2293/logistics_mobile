import 'package:flutter/material.dart';
import 'package:logistic/models/ktlogistics_token.dart';

class AddAirImportPage extends StatelessWidget {
  final KtLogisticsToken token;

  const AddAirImportPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Payment Request')),
      body: Center(
        child: Text('hi'),
      ),
    );
  }
}
