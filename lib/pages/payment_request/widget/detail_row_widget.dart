import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logistic/models/advancepayment_detail.dart';
import 'package:logistic/services/logistics_services.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For date formatting

class DetailRowWidget extends StatefulWidget {
  final AdvancePaymentDetail detail;
  final Function(AdvancePaymentDetail) onChanged;
  final VoidCallback onRemove;
  final List<String> jobNoList; // Danh sách jobNo
  final List<JobCarrier> jobCarrierList;
  final void Function(String jobNo)? onJobNoSelected; // ✅
  const DetailRowWidget({
    super.key,
    required this.detail,
    required this.onChanged,
    required this.jobCarrierList,
    required this.onRemove,
    required this.jobNoList,
    this.onJobNoSelected, // Thêm jobNoList vào constructor
  });

  @override
  State<DetailRowWidget> createState() => _DetailRowWidgetState();
}

class _DetailRowWidgetState extends State<DetailRowWidget> {
  late TextEditingController hblController;
  late TextEditingController amountController;
  late TextEditingController currencyController;
  late TextEditingController rateController;
  late TextEditingController intoMoneyController;
  late TextEditingController dateController;
  late TextEditingController carrierNameController;
  late String selectedJobNo;
  late String selectedHblNo;
  final LogisticsServices services = LogisticsServices();
  List<OptionModel> listHouseBills = [];
  @override
  void initState() {
    super.initState();

    hblController = TextEditingController(text: widget.detail.hblNo);
    amountController = TextEditingController(
      text: widget.detail.amountNumber.toString(),
    );
    currencyController = TextEditingController(text: widget.detail.curencyType);
    rateController = TextEditingController(
      text: widget.detail.exchangeRate.toString(),
    );
    intoMoneyController = TextEditingController(
      text: widget.detail.intoMoney.toString(),
    );
    dateController = TextEditingController(text: widget.detail.requestDate);
    carrierNameController = TextEditingController(
      text: widget.detail.carrierName,
    );

    selectedJobNo =
        widget.jobNoList.contains(widget.detail.hblNo)
            ? widget.detail.hblNo
            : (widget.jobNoList.isNotEmpty ? widget.jobNoList.first : '');

    // Gọi lấy MBL No theo Job No ban đầu
    _fetchMblNo(selectedJobNo);

    selectedHblNo = widget.detail.hblNo;
  }

  // Correctly defined _fetchMblNo inside the State class
  Future<void> _fetchMblNo(String jobNo) async {
    final prefs = await SharedPreferences.getInstance();
    final authenticateToken = prefs.getString('authenticateToken');
    final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

    if (authenticateToken == null || funcsTagActive.isEmpty) return;

    final raw = await services.listDocument(
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
    );

    final items = raw?['items'] as List<dynamic>? ?? [];

    final matchedJob = items.firstWhere(
      (item) => item['jobNo'] == jobNo,
      orElse: () => null,
    );

    if (matchedJob == null) {
      setState(() {
        listHouseBills.clear();
      });
      return;
    }

    final jobId = matchedJob['jobId'] ?? 0;
    //final jobId = 2;
    final typesImpExpId = matchedJob['typesImpExpId'] ?? 0;

    final carrierId = matchedJob['carrierId'] ?? 0;
    // Get job details by type
    final jobDetail = await services.getJobDetailByType(
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
      typesImpExpId: typesImpExpId,
      jobId: jobId,
    );

    final fwHouseBills =
        jobDetail?['oneItem']?['fw_HouseBills'] as List<dynamic>? ?? [];

    setState(() {
      listHouseBills =
          fwHouseBills
              .map(
                (e) => OptionModel(
                  value: e['mblNo']?.toString() ?? '',
                  text: e['mblNo']?.toString() ?? '',
                ),
              )
              .toList();
    });
    if (listHouseBills.isNotEmpty) {
      hblController.text = listHouseBills.first.value;
    } else {
      hblController.clear();
    }
  }

  void _onFieldChanged() {
    final amount = double.tryParse(amountController.text) ?? 0;
    final rate = double.tryParse(rateController.text) ?? 1;
    final intoMoney = amount * rate;

    final updated = AdvancePaymentDetail(
      hblNo: hblController.text,
      amountNumber: amount,
      curencyType: currencyController.text,
      exchangeRate: rate,
      intoMoney: intoMoney,
      requestDate: dateController.text,
      carrierName: carrierNameController.text,
    );

    intoMoneyController.text = intoMoney.toStringAsFixed(0);
    // Cập nhật carrier name khi jobNo thay đổi
    _updateCarrierName(selectedJobNo);
    widget.onChanged(updated);
  }

  void _updateCarrierName(String jobNo) {
    final carrier = widget.jobCarrierList.firstWhere(
      (item) => item.jobNo == jobNo,
      orElse: () => JobCarrier(jobNo: '', carrierName: ''),
    );
    carrierNameController.text = carrier.carrierName;
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dateController.text) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formatted = DateFormat(
        'yyyy-MM-dd',
      ).format(picked); // Standard date format
      dateController.text = formatted;
      _onFieldChanged();
    }
  }

 @override
Widget build(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(width: 8),
          Row(
            children: [
              _buildDropdownField(
                label: 'Job No',
                value: selectedJobNo,
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedJobNo = newValue;
                    });
                    _updateCarrierName(newValue);
                    _onFieldChanged();
                    _fetchMblNo(newValue);
                    widget.onJobNoSelected?.call(newValue);
                  }
                },
                items: widget.jobNoList,
              ),
              const SizedBox(width: 8),
              _buildDropdownField(
                label: 'MBL No',
                value: hblController.text.isNotEmpty &&
                        listHouseBills.any(
                            (e) => e.value == hblController.text)
                    ? hblController.text
                    : null,
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      hblController.text = newValue;
                    });
                    _onFieldChanged();
                  }
                },
                items: listHouseBills.map((e) => e.value).toList(),
              ),
               const SizedBox(width: 8),
                _buildField(amountController, 'Amount', keyboardType: TextInputType.number)
            ],
             
          ),
          
          Row(
            children: [
              _buildField(currencyController, 'Currency'),
              const SizedBox(width: 8),
              _buildField(
                rateController,
                'Exchange Rate',
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildField(intoMoneyController, 'Into Money', enabled: false),
              const SizedBox(width: 8),
              _buildField(
                dateController,
                'Request Date',
                readOnly: true,
                onTap: _pickDate,
              ),
              IconButton(
                onPressed: widget.onRemove,
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

 
  Widget _buildDropdownField({
  required String label,
  required String? value,
  required ValueChanged<String?> onChanged,
  required List<String> items,
}) {
  return Expanded(
    child: DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
    ),
  );
}


  Widget _buildField(
    TextEditingController controller,
    String label, {
    bool enabled = true,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        onChanged: (_) => _onFieldChanged(),
        enabled: enabled,
        readOnly: readOnly,
        keyboardType: keyboardType,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}

class JobCarrier {
  final String jobNo;
  final String carrierName;

  JobCarrier({required this.jobNo, required this.carrierName});
}

class OptionModel {
  final String value;
  final String text;

  OptionModel({required this.value, required this.text});
}
  