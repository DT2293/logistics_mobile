
import 'package:flutter/material.dart';
import 'package:logistic/models/document_model.dart';
import 'package:logistic/widgets/base_scaffold.dart';

class AirExportPage extends BaseListPage<FwDocumentationViewModel> {
  final FwDocumentationViewModel data;

  const AirExportPage({
    super.key,
    required this.data,
  }) : super(title: 'Air Export');

  @override
  Future<List<FwDocumentationViewModel>> fetchItems() async {
    return data.items.map((e) => FwDocumentationViewModel.fromJson(e)).toList();
  }
 @override
  void onDeleteItem(FwDocumentationViewModel item) {
    // Tuỳ xử lý xoá ở đây (gọi API xóa, hoặc log, hoặc hiển thị toast...)
    print(' Đã xóa: ${item.billNo}');
  }
  @override
  List<DataColumn> get columns => const [
        DataColumn(label: Text('Job No')),
        DataColumn(label: Text('ETD')),
        DataColumn(label: Text('Customer')),
      ];

  @override
  List<DataCell> buildCells(FwDocumentationViewModel item) => [
        DataCell(Text(item.jobNo ?? '')),
        DataCell(Text(item.etd ?? '')),
        DataCell(Text(item.customerConsigneeInfo ?? '')),
      ];

  @override
  Widget buildDetailPopup(FwDocumentationViewModel job) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Job No: ${job.jobNo ?? 'N/A'}'),
          Text('ETD: ${job.etd ?? 'N/A'}'),
          Text('Customer: ${job.customerConsigneeInfo ?? 'N/A'}'),
          Text('POL: ${job.polName ?? 'N/A'}'),
        ],
      );
}
