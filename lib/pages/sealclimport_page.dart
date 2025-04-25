import 'package:flutter/material.dart';
import 'package:logistic/models/document_model.dart';
 // đúng model bạn dùng

class SeaLCLImportPage extends StatelessWidget {
  final FwDocumentationViewModel data;

  const SeaLCLImportPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sea FCL Export')),
      body: Center(
        child: Text('Mã chứng từ: ${data.agentName ?? "Không có"}'), // tuỳ vào model
      ),
    );
  }
}
