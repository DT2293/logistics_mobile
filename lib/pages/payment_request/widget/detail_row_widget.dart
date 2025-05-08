import 'package:flutter/material.dart';
import 'package:logistic/models/advancepayment_detail.dart';

class DetailRowWidget extends StatefulWidget {
  final AdvancePaymentDetail detail;
  final Function(AdvancePaymentDetail) onChanged;
  final VoidCallback onRemove;
  final List<String> jobNoList; // Danh sách jobNo

  const DetailRowWidget({
    super.key,
    required this.detail,
    required this.onChanged,
    required this.onRemove,
    required this.jobNoList, // Thêm jobNoList vào constructor
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
  late String selectedJobNo;


 @override
void initState() {
  super.initState();
  hblController = TextEditingController(text: widget.detail.hblNo);
  amountController = TextEditingController(text: widget.detail.amountNumber.toString());
  currencyController = TextEditingController(text: widget.detail.curencyType);
  rateController = TextEditingController(text: widget.detail.exchangeRate.toString());
  intoMoneyController = TextEditingController(text: widget.detail.intoMoney.toString());
  dateController = TextEditingController(text: widget.detail.requestDate);

  // Đảm bảo selectedJobNo là giá trị hợp lệ trong dropdown
  selectedJobNo = widget.jobNoList.contains(widget.detail.hblNo)
      ? widget.detail.hblNo
      : (widget.jobNoList.isNotEmpty ? widget.jobNoList.first : '');
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
    );

    intoMoneyController.text = intoMoney.toStringAsFixed(0);
    widget.onChanged(updated);
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dateController.text) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formatted = '${picked.day}/${picked.month}/${picked.year}';
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
            Row(
              children: [
                _buildDropdownField('Job No', selectedJobNo, (newValue) {
                  setState(() {
                    selectedJobNo = newValue!;
                    _onFieldChanged();
                  });
                }),
                const SizedBox(width: 8),
                _buildField(hblController, 'HBL No'),
                const SizedBox(width: 8),
                _buildField(amountController, 'Amount', keyboardType: TextInputType.number),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildField(currencyController, 'Currency'),
                const SizedBox(width: 8),
                _buildField(rateController, 'Exchange Rate', keyboardType: TextInputType.number),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildField(intoMoneyController, 'Into Money', enabled: false),
                const SizedBox(width: 8),
                _buildField(dateController, 'Request Date', readOnly: true, onTap: _pickDate),
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

  Widget _buildDropdownField(String label, String value, ValueChanged<String?> onChanged) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: widget.jobNoList.map((jobNo) {
          return DropdownMenuItem<String>(
            value: jobNo, 
            child: Text(jobNo),
          );
        }).toList(),
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
