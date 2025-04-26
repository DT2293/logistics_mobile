
import 'package:flutter/material.dart';
import 'package:logistic/models/document_model.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/widgets/base_scaffold.dart';

class SeaLCLExportPage extends BaseListPage<FwDocumentationViewModel> {
  final FwDocumentationViewModel data;
  final KtLogisticsToken token;
  const SeaLCLExportPage({
    super.key,
    required this.data,
    required this.token
  }) : super(title: 'Sea LCL Export', token: token);

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
