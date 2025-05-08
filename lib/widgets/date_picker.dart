// date_picker.dart
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final String dateText;
  final VoidCallback onTap;

  const DatePicker({
    Key? key,
    required this.dateText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        dateText,
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
