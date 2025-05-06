import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/models/payment_request_model.dart';
import 'package:logistic/services/logistics_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAdvancePaymentRequestPage extends StatefulWidget {
  final KtLogisticsToken token;

  const AddAdvancePaymentRequestPage({super.key, required this.token});

  @override
  State<AddAdvancePaymentRequestPage> createState() =>
      _AddAdvancePaymentRequestPageState();
}

class _AddAdvancePaymentRequestPageState
    extends State<AddAdvancePaymentRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _amountInWordsController =TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
final LogisticsServices service = LogisticsServices();
  List<AdvancePaymentDetail> _details = [];
Future<void> submitAdvancePaymentRequest() async {

  final prefs = await SharedPreferences.getInstance();
  final authenticateToken = prefs.getString('authenticateToken');
  final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

  if (_formKey.currentState?.validate() ?? false) {
 final body = {
  "advancePaymentRequestId": 0,
  "advancePaymentNo": _numberController.text,
  "deparmentId": widget.token.userLogisticsInfosModels.oneUserLogisticsInfo.departmentId ?? 0,
  "jobId": "",
  "advancePaymentDate": _dateController.text,
  "advancePaymentType": 0, // bạn có thể map thêm nếu cần
  "curencyType": "VND", // hoặc lấy từ controller nếu có
  "advanceAmountNumber": double.tryParse(_amountController.text) ?? 0,
  "advanceAmountString": _amountInWordsController.text,
  "description": _descriptionController.text,
  "director": "", // điền tên giám đốc nếu có
  "chiefAccountant": "", // kế toán trưởng
  "headDepartment": "", // trưởng bộ phận
  "documentRep": "", // người đại diện chứng từ
  "applicant": widget.token.userLogisticsInfosModels.oneUserLogisticsInfo.userId,
  "directorDate": "", // có thể dùng DateTime.now().toIso8601String()
  "chiefAccountantDate": "",
  "headDepartmentDate": "",
  "documentRepDate": "",
  "applicantDate": DateTime.now().toIso8601String(),
  "unclearAdvance": false,
  "isDeleted": false,
  "lstDetail": _details.map((e) => {
    "id": 0,
    "description": e.description ?? "", // thêm description nếu có
    "hblNo": e.hblNo,
    "amountNumber": e.amountNumber,
    "amountString": "", // bạn có thể tự convert nếu cần
    "curencyType": e.curencyType,
    "exchangeRate": e.exchangeRate,
    "intoMoney": e.intoMoney,
    "requestDate": e.requestDate,
    "contractNo": e.contractNo ?? "",
    "isDM": e.isDM ?? false,
    "isHD": e.isHD ?? false,
    "isOther": e.isOther ?? false,
  }).toList(),
};


    try {
      EasyLoading.show(status: 'Đang gửi...');
      final response = await service.addAdvancePayment(
        body: body,
        authenticateToken: authenticateToken ?? '', 
        funcsTagActive: funcsTagActive, // hoặc tag phù hợp
      );

      EasyLoading.dismiss();

      if (response != null && response['success'] == true) {
        Fluttertoast.showToast(msg: 'Gửi yêu cầu thành công');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: response?['message'] ?? 'Gửi yêu cầu thất bại',
          backgroundColor: Colors.red,
        );
      }
      print('📤 Body: ${jsonEncode(body)}');
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: 'Đã xảy ra lỗi: $e',
        backgroundColor: Colors.red,
      );
    }
  }
}

  String getDepartmentName(int id) {
    switch (id) {
      case 1:
        return 'Sale';
      case 2:
        return 'Management';
      case 3:
        return 'Documentation department';
      default:
        return 'Không xác định';
    }
  }

  Future<void> _pickDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  @override
Widget build(BuildContext context) {
  // Hàm tính tổng số tiền từ bảng chi tiết
  double _getTotalAmount() {
    return _details.fold(0.0, (sum, detail) => sum + detail.intoMoney);
  }

  // Hàm chuyển số tiền thành chữ
 String _convertNumberToWords(double number) {
  // Mảng ánh xạ số nguyên cơ bản
  const numberToWords = {
    0: 'Không',
    1: 'Một',
    2: 'Hai',
    3: 'Ba',
    4: 'Bốn',
    5: 'Năm',
    6: 'Sáu',
    7: 'Bảy',
    8: 'Tám',
    9: 'Chín',
    10: 'Mười',
    100: 'Trăm',
    1000: 'Nghìn',
    1000000: 'Triệu',
    1000000000: 'Tỷ'
  };

  // Hàm chuyển phần nguyên sang chữ
  String _convertPart(int number) {
    if (number == 0) return numberToWords[0]!;

    String result = '';
    if (number >= 100) {
      int hundreds = number ~/ 100;
      result += '${numberToWords[hundreds]} ${numberToWords[100]} ';
      number %= 100;
    }

    if (number >= 20) {
      int tens = number ~/ 10;
      result += '${numberToWords[tens]} Mươi ';
      number %= 10;
    } else if (number >= 10) {
      result += '${numberToWords[10]} ';
      number %= 10;
    }

    if (number > 0) {
      result += '${numberToWords[number]}';
    }

    return result.trim();
  }

  // Hàm chuyển phần nguyên thành chữ cho các nhóm (nghìn, triệu, tỷ,...)
  String _convertIntegerPart(int number) {
    if (number == 0) return numberToWords[0]!;

    List<String> parts = [];
    List<int> unitValues = [1000000000, 1000000, 1000, 1];  // Tỷ, triệu, nghìn, đơn vị
    List<String> unitNames = ['Tỷ', 'Triệu', 'Nghìn', ''];  // Đơn vị tương ứng

    for (int i = 0; i < unitValues.length; i++) {
      int unitValue = unitValues[i];
      if (number >= unitValue) {
        int part = number ~/ unitValue;
        parts.add('${_convertPart(part)} ${unitNames[i]}');
        number %= unitValue;
      }
    }

    return parts.join(' ').trim();
  }

  // Phần nguyên
  int integerPart = number.toInt();
  String integerPartInWords = _convertIntegerPart(integerPart);

  // Phần thập phân
  String decimalPartInWords = '';
  if (number != integerPart) {
    String decimalPart = (number - integerPart).toString().substring(2);
    decimalPartInWords = 'phẩy ';
    for (int i = 0; i < decimalPart.length; i++) {
      decimalPartInWords += '${numberToWords[int.parse(decimalPart[i])]} ';
    }
  }

  return '$integerPartInWords $decimalPartInWords'.trim();
}
  // Cập nhật giá trị số tiền và bằng chữ mỗi khi bảng chi tiết thay đổi
  _amountController.text = _getTotalAmount().toString();
  _amountInWordsController.text = _convertNumberToWords(_getTotalAmount());

 return Scaffold(
  appBar: AppBar(title: const Text('Add Advance Payment Request')),
  body: Padding(
    padding: const EdgeInsets.all(16),
    child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ĐỀ NGHỊ TẠM ỨNG',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              'Người đề nghị: ${widget.token.userLogisticsInfosModels.oneUserLogisticsInfo.userName}',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Text(
              'Trực thuộc phòng: ${getDepartmentName(widget.token.userLogisticsInfosModels.oneUserLogisticsInfo.departmentId)}',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _numberController,
                      decoration: const InputDecoration(
                        labelText: 'Số hiệu',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Bắt buộc nhập' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Ngày',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () => _pickDate(_dateController),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Bắt buộc nhập' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: 'Số tiền tạm ứng',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Bắt buộc nhập' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountInWordsController,
                      decoration: const InputDecoration(
                        labelText: 'Bằng chữ',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Bắt buộc nhập' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Diễn giải',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Chi tiết tạm ứng:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 12,
                columns: const [
                  DataColumn(label: Text('HBL No')),
                  DataColumn(label: Text('Số tiền')),
                  DataColumn(label: Text('Loại tiền')),
                  DataColumn(label: Text('Tỷ giá')),
                  DataColumn(label: Text('Thành tiền')),
                  DataColumn(label: Text('Ngày thanh toán')),
                  DataColumn(label: Text('Xóa')),
                ],
                rows: List.generate(_details.length, (index) {
                  final detail = _details[index];
                  return DataRow(cells: [
                    DataCell(TextFormField(
                      initialValue: detail.hblNo,
                      onChanged: (val) => setState(() {
                        detail.hblNo = val;
                        _amountController.text = _getTotalAmount().toString();
                        _amountInWordsController.text = _convertNumberToWords(_getTotalAmount());
                      }),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
                    DataCell(TextFormField(
                      initialValue: detail.amountNumber.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          detail.amountNumber = double.tryParse(val) ?? 0;
                          detail.intoMoney = detail.amountNumber * detail.exchangeRate;
                          _amountController.text = _getTotalAmount().toString();
                          _amountInWordsController.text = _convertNumberToWords(_getTotalAmount());
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
                    DataCell(DropdownButtonFormField<String>(
                      value: detail.curencyType,
                      items: ['VND', 'USD', 'EUR']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            detail.curencyType = val;
                            _amountController.text = _getTotalAmount().toString();
                            _amountInWordsController.text = _convertNumberToWords(_getTotalAmount());
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
                    DataCell(TextFormField(
                      initialValue: detail.exchangeRate.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          detail.exchangeRate = double.tryParse(val) ?? 1;
                          detail.intoMoney = detail.amountNumber * detail.exchangeRate;
                          _amountController.text = _getTotalAmount().toString();
                          _amountInWordsController.text = _convertNumberToWords(_getTotalAmount());
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
                    DataCell(Text(detail.intoMoney.toStringAsFixed(2))),
                    DataCell(InkWell(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() {
                            detail.requestDate = '${picked.day}/${picked.month}/${picked.year}';
                            _amountController.text = _getTotalAmount().toString();
                            _amountInWordsController.text = _convertNumberToWords(_getTotalAmount());
                          });
                        }
                      },
                      child: Text(
                        detail.requestDate.isNotEmpty ? detail.requestDate : 'Chọn ngày',
                        style: const TextStyle(decoration: TextDecoration.underline),
                      ),
                    )),
                    DataCell(IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _details.removeAt(index);
                          _amountController.text = _getTotalAmount().toString();
                          _amountInWordsController.text = _convertNumberToWords(_getTotalAmount());
                        });
                      },
                    )),
                  ]);
                }),
              ),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _details.add(AdvancePaymentDetail(
                    hblNo: '',
                    amountNumber: 0,
                    curencyType: 'VND',
                    exchangeRate: 1,
                    intoMoney: 0,
                    requestDate: '',
                  ));
                  _amountController.text = _getTotalAmount().toString();
                  _amountInWordsController.text = _convertNumberToWords(_getTotalAmount());
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Thêm dòng'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               ElevatedButton(
  onPressed: submitAdvancePaymentRequest,
  child: const Text('Gửi yêu cầu'),
),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    setState(() {
                      _details.clear();
                      _amountController.clear();
                      _amountInWordsController.clear();
                    });
                  },
                  child: const Text('Hủy bỏ'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
);

}

}

class AdvancePaymentDetail {
  int id;
  String description;
  String hblNo;
  double amountNumber;
  String amountString;
  String curencyType;
  double exchangeRate;
  double intoMoney;
  String requestDate;
  String contractNo;
  bool isDM;
  bool isHD;
  bool isOther;

  AdvancePaymentDetail({
    this.id = 0,
    this.description = '',
    this.hblNo = '',
    this.amountNumber = 0,
    this.amountString = '',
    this.curencyType = 'VND',
    this.exchangeRate = 1,
    this.intoMoney = 0,
    this.requestDate = '',
    this.contractNo = '',
    this.isDM = false,
    this.isHD = false,
    this.isOther = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'hblNo': hblNo,
    'amountNumber': amountNumber,
    'amountString': amountString,
    'curencyType': curencyType,
    'exchangeRate': exchangeRate,
    'intoMoney': intoMoney,
    'requestDate': requestDate,
    'contractNo': contractNo,
    'isDM': isDM,
    'isHD': isHD,
    'isOther': isOther,
  };
}
