import 'package:flutter/material.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/models/payment_request_model.dart';
import 'package:logistic/pages/payment_request/widget/advance_payment_form.dart';


class AddAdvancePaymentPage extends StatelessWidget {
  final KtLogisticsToken token;
   final List<AdvancePaymentRequestViewModel> data;
  const AddAdvancePaymentPage({super.key, required this.token, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Advance Payment Request')),
      body: AdvancePaymentForm(token: token, data: data,),
    );
  }
}
