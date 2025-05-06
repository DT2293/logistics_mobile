
import 'package:flutter/material.dart';
import 'package:logistic/models/document_model.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/sea_fcl_import/addsea_fcl_import_page.dart';
import 'package:logistic/widgets/base_scaffold.dart';

class SeaFCLImportPage extends BaseListPage<FwDocumentationViewModel> {
  final FwDocumentationViewModel data;
  final KtLogisticsToken token;
  const SeaFCLImportPage({
    super.key,
    required this.data,
    required this.token
  }) : super(title: 'Sea FCL Imort',token: token);

  @override
  Future<List<FwDocumentationViewModel>> fetchItems() async {
    return data.items.map((e) => FwDocumentationViewModel.fromJson(e)).toList();
  }
    @override
void onAddPressed(BuildContext context) {
    // Cần truyền BuildContext vào phương thức này
    print('Add button pressed');
    // Mở một màn hình mới (hoặc thực hiện hành động khác)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSeaFCLImportPage(token: token,), // Thay AddSeaLCLImportPage bằng trang của bạn
      ),
    );
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
    DataColumn(label: Text('NameUserCreate')),
    DataColumn(label: Text('Customer')),
    DataColumn(label: Text('POL')),
    DataColumn(label: Text('POD')),
    DataColumn(label: Text('Carrier Name')),
    DataColumn(label: Text('CusShipInf')),
    DataColumn(label: Text('SalesName')),
    DataColumn(label: Text('Container')),
    DataColumn(label: Text('Qty')),
    DataColumn(label: Text('G.W')),
    DataColumn(label: Text('N.W')),
    DataColumn(label: Text('CBM')),
  ];

 @override
List<DataCell> buildCells(FwDocumentationViewModel item) => [
  DataCell(Text(item.jobNo ?? '')),
  DataCell(Text(item.etd ?? '')),
  DataCell(Text(item.NameUserCreate ?? '')),
  DataCell(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: item.customerConsigneeInfo != null
          ? item.customerConsigneeInfo!.split(',').map((info) => Text(info.trim())).toList()
          : [Text('No information available')],
    ),
  ),
  DataCell(Text(item.polName ?? '')),
  DataCell(Text(item.podName ?? '')),
  DataCell(Text(item.carrierName ?? '')),
  DataCell(Text(item.customerShipperInfo ?? '')),
  DataCell(Text(item.salesname ?? '')),
  DataCell(Text(item.containers ?? '')),
  DataCell(Text(item.qty?.toString() ?? '')),
  DataCell(Text(item.gw?.toString() ?? '')),
  DataCell(Text(item.nw?.toString() ?? '')),
  DataCell(Text(item.cbm?.toString() ?? '')),
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
