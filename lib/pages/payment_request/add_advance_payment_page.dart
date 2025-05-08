import 'package:flutter/material.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/payment_request/widget/advance_payment_form.dart';


class AddAdvancePaymentPage extends StatelessWidget {
  final KtLogisticsToken token;
  const AddAdvancePaymentPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Advance Payment Request')),
      body: AdvancePaymentForm(token: token),
    );
  }
}
