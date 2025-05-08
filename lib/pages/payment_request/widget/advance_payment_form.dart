import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logistic/models/advancepayment_detail.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/services/logistics_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'form_fields.dart';
import 'detail_table.dart';
import '../utils/department_utils.dart';
import '../utils/number_to_words.dart';

class AdvancePaymentForm extends StatefulWidget {
  final KtLogisticsToken token;
  const AdvancePaymentForm({super.key, required this.token});

  @override
  State<AdvancePaymentForm> createState() => _AdvancePaymentFormState();
}

class _AdvancePaymentFormState extends State<AdvancePaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _dateController = TextEditingController();
  final _amountController = TextEditingController();
  final _amountInWordsController = TextEditingController();
  final _descriptionController = TextEditingController();
  final TextEditingController _carrierNameController = TextEditingController();
final TextEditingController _containersController = TextEditingController();

  final TextEditingController _jobIdController = TextEditingController();
  List<AdvancePaymentDetail> _details = [];
  final LogisticsServices service = LogisticsServices();

  List<String> _jobNoList = [];
  bool _isLoading = true;

@override
void initState() {
  super.initState();
  fetchJobNos();
}

  Future<void> fetchJobNos() async {
    final prefs = await SharedPreferences.getInstance();
    final authenticateToken = prefs.getString('authenticateToken');
    final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

    if (authenticateToken != null && funcsTagActive.isNotEmpty) {
      final raw = await service.listDocument(
        authenticateToken: authenticateToken,
        funcsTagActive: funcsTagActive,
      );

      if (raw != null && raw['items'] is List) {
        final items = raw['items'] as List;
        print(items);
        setState(() {
          _jobNoList =
              items
                  .where((item) => item['jobNo'] != null)
                  .map<String>((item) => item['jobNo'] as String)
                  .toList();
          _isLoading = false;
        });
      }
    }
  }

  // Placeholder methods
  double _getTotalAmount() => _details.fold(0, (sum, d) => sum + d.intoMoney);
  String _convertNumberToWords(double amount) => convertNumberToWords(amount);
  //  void submitAdvancePaymentRequest() {/*...*/}
  void submitAdvancePaymentRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final authenticateToken = prefs.getString('authenticateToken');
    final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

    if (_formKey.currentState?.validate() ?? false) {
      final selectedJobId = _jobIdController.text;

      final body = {
        "advancePaymentRequestId": 0,
        "advancePaymentNo": _numberController.text,
        "deparmentId":
            widget
                .token
                .userLogisticsInfosModels
                .oneUserLogisticsInfo
                .departmentId ??
            0,
        "jobId": selectedJobId,
        "advancePaymentDate": _dateController.text,
        "advancePaymentType": 0,
        "curencyType": "VND",
        "advanceAmountNumber": double.tryParse(_amountController.text) ?? 0,
        "advanceAmountString": _amountInWordsController.text,
        "description": _descriptionController.text,
        "director": "",
        "chiefAccountant": "",
        "headDepartment": "",
        "documentRep": "",
        "applicant":
            widget.token.userLogisticsInfosModels.oneUserLogisticsInfo.userId,
        "directorDate": "",
        "chiefAccountantDate": "",
        "headDepartmentDate": "",
        "documentRepDate": "",
        "applicantDate": DateTime.now().toIso8601String(),
        "unclearAdvance": false,
        "isDeleted": false,
        "lstDetail":
            _details
                .map(
                  (e) => {
                    "id": 0,
                    "description": e.description ?? "",
                    "hblNo": e.hblNo,
                    "amountNumber": e.amountNumber,
                    "amountString": "",
                    "curencyType": e.curencyType,
                    "exchangeRate": e.exchangeRate,
                    "intoMoney": e.intoMoney,
                    "requestDate": e.requestDate,
                    "contractNo": e.contractNo ?? "",
                    "isDM": e.isDM ?? false,
                    "isHD": e.isHD ?? false,
                    "isOther": e.isOther ?? false,
                  },
                )
                .toList(),
      };

      try {
        EasyLoading.show(status: 'Đang gửi...');
        final response = await service.addAdvancePayment(
          body: body,
          authenticateToken: authenticateToken ?? '',
          funcsTagActive: funcsTagActive,
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

        debugPrint('📤 Body: ${jsonEncode(body)}');
      } catch (e) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: 'Đã xảy ra lỗi: $e',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.token.userLogisticsInfosModels.oneUserLogisticsInfo;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ĐỀ NGHỊ TẠM ỨNG',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.blue),
              ),

              const SizedBox(height: 8),
              Text('Người đề nghị: ${user.userName}'),
              Text('Trực thuộc phòng: ${getDepartmentName(user.departmentId)}'),
              const SizedBox(height: 16),
              FormFields(
                numberController: _numberController,
                dateController: _dateController,
                amountController: _amountController,
                amountInWordsController: _amountInWordsController,
                descriptionController: _descriptionController,
                onPickDate: () => _pickDate(_dateController), 
               carrierNameController: _carrierNameController,
containersController: _containersController,

              ),
              const SizedBox(height: 20),
              const Text(
                'Chi tiết tạm ứng:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DetailTable(
                details: _details,
                jobNoList: _jobNoList,
                onDetailsChanged: (updatedList) {
                  setState(() {
                    _details = updatedList;
                    _amountController.text = _getTotalAmount().toString();
                    _amountInWordsController.text = _convertNumberToWords(
                      _getTotalAmount(),
                    );
                  });
                },
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Thêm dòng'),
                onPressed: () {
                  setState(() {
                    _details.add(AdvancePaymentDetail.defaultDetail());
                  });
                },
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
    );
  }

  void _pickDate(TextEditingController controller) async {
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
}
