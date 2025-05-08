// job_dropdown.dart
import 'package:flutter/material.dart';

class JobDropdown extends StatelessWidget {
  final List<Map<String, dynamic>> jobItems;
  final String? selectedJobNo;
  final ValueChanged<String?> onChanged;

  const JobDropdown({
    Key? key,
    required this.jobItems,
    required this.selectedJobNo,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedJobNo,
      decoration: const InputDecoration(
        labelText: 'Chọn Job No',
        border: OutlineInputBorder(),
      ),
      items: jobItems.map((job) {
        return DropdownMenuItem<String>(
          value: job['jobNo'],
          child: Text(job['jobNo'] ?? 'Không có Job No'),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
