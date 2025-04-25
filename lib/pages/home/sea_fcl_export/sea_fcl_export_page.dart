import 'package:flutter/material.dart';
import 'package:logistic/models/document_model.dart';


class SeaFCLExportPage extends StatelessWidget {
  final FwDocumentationViewModel data;
  const SeaFCLExportPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sea FCL Export')),
      body: ListView.builder(
        itemCount: data.items?.length ?? 0,
        itemBuilder: (context, index) {
          final item = data.items![index];
          return ListTile(
            title: Text(item.jobNo ?? '---'),
            subtitle: Text(item.shipperName ?? ''),
          );
        },
      ),
    );
  }
}
