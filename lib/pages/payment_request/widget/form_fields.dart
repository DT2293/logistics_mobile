import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  final TextEditingController numberController;
  final TextEditingController dateController;
  final TextEditingController amountController;
  final TextEditingController amountInWordsController;
  final TextEditingController descriptionController;
  final TextEditingController carrierNameController;
final TextEditingController containersController;

  final VoidCallback onPickDate;

  const FormFields({
    super.key,
    required this.numberController,
    required this.dateController,
    required this.amountController,
    required this.amountInWordsController,
    required this.descriptionController,
      required this.carrierNameController,    
  required this.containersController,      
    required this.onPickDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
  children: [
    _buildField(numberController, 'Số hiệu'),
    const SizedBox(height: 16),
    _buildField(dateController, 'Ngày', readOnly: true, onTap: onPickDate),
    const SizedBox(height: 16),
    _buildField(amountController, 'Số tiền tạm ứng', keyboardType: TextInputType.number),
    const SizedBox(height: 16),
    _buildField(amountInWordsController, 'Bằng chữ'),
    const SizedBox(height: 16),
    _buildField(descriptionController, 'Diễn giải', maxLines: 3),
    const SizedBox(height: 16),
    _buildField(carrierNameController, 'Tên hãng vận chuyển'),          // Thêm trường này
    const SizedBox(height: 16),
    _buildField(containersController, 'Danh sách Container'),          // Thêm trường này
  ],
),

      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label,
      {bool readOnly = false, VoidCallback? onTap, int maxLines = 1, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (val) => val == null || val.isEmpty ? 'Bắt buộc nhập' : null,
    );
  }
}
