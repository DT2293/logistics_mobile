import 'package:flutter/material.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/models/payment_request_model.dart';
import 'package:logistic/pages/payment_request/addpayment_request_page.dart';
import 'package:logistic/widgets/base_scaffold.dart';


class AdvancePaymentPage extends BaseListPage<AdvancePaymentRequestViewModel> {
  final List<AdvancePaymentRequestViewModel> data;
  final KtLogisticsToken token;

  const AdvancePaymentPage({super.key, required this.data, required this.token})
    : super(title: 'Advance Payment Requests', token: token);

  @override
  Future<List<AdvancePaymentRequestViewModel>> fetchItems() async {
    return data;
  }

  @override
  void onDeleteItem(AdvancePaymentRequestViewModel item) {
    print('Đã xóa: ${item.advancePaymentNo}');
  }

  @override
void onAddPressed(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddAdvancePaymentRequestPage(token: token),
    ),
  );
}

  @override
  List<DataColumn> get columns => const [
    DataColumn(label: Text('Advance No')),
    DataColumn(label: Text('Advance Date')),
    DataColumn(label: Text('AdvancePayment Type')),
    DataColumn(label: Text('AdvanceAmount Number')),
    DataColumn(label: Text('AdvanceAmount String')),
    DataColumn(label: Text('Deparment')),
    DataColumn(label: Text('Description')),
  ];

  @override
  List<DataCell> buildCells(AdvancePaymentRequestViewModel item) => [
    DataCell(Text(item.advancePaymentNo ?? '')),
    DataCell(Text(item.advancePaymentDate ?? '')),
    DataCell(Text(item.advancePaymentType.toString())),
    DataCell(Text(item.advanceAmountNumber.toString())),
    DataCell(Text(item.advanceAmountString ?? '')),
    DataCell(
      Text(
        item.deparmentId == 1
            ? "Sale"
            : item.deparmentId == 2
            ? "Management"
            : item.deparmentId == 3
            ? "Documentation department"
            : '',
      ),
    ),
    DataCell(Text(item.description ?? '')),
  ];

  @override
  Widget buildDetailPopup(AdvancePaymentRequestViewModel job) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ĐỀ NGHỊ TẠM ỨNG',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text('Số hiệu: ${job.advancePaymentNo}')),
                Expanded(child: Text('Ngày: ${job.advancePaymentDate}')),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text('Kiểu: ${job.advancePaymentType}')),
                Expanded(child: Text('Người đề nghị: ${job.applicant}')),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text('Trực thuộc phòng: ${job.deparmentId}')),
              ],
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Số tiền tạm ứng: ${job.advanceAmountNumber.toString()}',
                  ),
                ),
                Expanded(child: Text('${job.curencyType}')),
              ],
            ),
            Text('Bằng chữ: ${job.advanceAmountString}'),
            Text('Diễn giải: ${job.description}'),

            const SizedBox(height: 12),
            const Text(
              'Chi tiết:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Descirption')),
                  DataColumn(label: Text('Số H-B/L')),
                  DataColumn(label: Text('Số tiền')),
                  DataColumn(label: Text('Loại tiền')),
                  DataColumn(label: Text('Tỷ giá')),
                  DataColumn(label: Text('Thành tiền')),
                  DataColumn(label: Text('Ngày thanh toán')),
                  DataColumn(label: Text('Số HĐ')),
                  DataColumn(label: Text('ĐM')),
                  DataColumn(label: Text('HĐ')),
                  DataColumn(label: Text('Khác')),
                ],
                rows:
                    job.lstDetail.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item.description)),
                          DataCell(Text(item.hblNo)),
                          DataCell(Text(item.amountNumber.toString())),
                          DataCell(Text(item.curencyType)),
                          DataCell(Text(item.exchangeRate.toString())),
                          DataCell(Text(item.intoMoney.toString())),
                          DataCell(Text(item.requestDate)),
                          DataCell(Text(item.contractNo)),
                          DataCell(Text(item.isDM ? '✔' : '')),
                          DataCell(Text(item.isHD ? '✔' : '')),
                          DataCell(Text(item.isOther ? '✔' : '')),
                        ],
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 12),
            Text('Giám Đốc /Ký: ${job.directorDate}'),
            Text('Kế Toán Trưởng /Ký: ${job.chiefAccountantDate}'),
            Text('Trưởng Phòng /Ký: ${job.headDepartmentDate}'),
            Text('Đại diện chứng từ /Ký: ${job.documentRepDate}'),
            Text('Người Đề Nghị /Ký: ${job.applicantDate}'),
          ],
        ),
      );
}
